const functions = require("firebase-functions");
const admin = require("firebase-admin");

// FlutterFlow initializes Firebase Admin automatically.

exports.finalizeOnboarding = functions.https.onCall(async (data, context) => {
  const HttpsError = functions.https.HttpsError;

  if (!context.auth || !context.auth.uid) {
    throw new HttpsError("unauthenticated", "Please sign in again.");
  }

  const uid = context.auth.uid;
  const p = data && data.payload;

  if (!p || typeof p !== "object" || Array.isArray(p)) {
    throw new HttpsError("invalid-argument", "Invalid onboarding information.");
  }

  const fullName = String(p.fullName || "")
    .trim()
    .replace(/\s+/g, " ");

  const username = String(p.username || "")
    .trim()
    .replace(/^@/, "")
    .toLowerCase();

  const inviteCode = String(p.inviteCode || "")
    .trim()
    .toUpperCase();

  if (fullName.length < 2 || fullName.length > 80) {
    throw new HttpsError("invalid-argument", "Enter a valid full name.");
  }

  if (!/^[a-z0-9_.]{3,24}$/.test(username) || username.includes("..")) {
    throw new HttpsError(
      "invalid-argument",
      "Username must be 3–24 characters using letters, numbers, _ or .",
    );
  }

  const photoPath = String(p.profilePhotoPath || "");

  if (photoPath && photoPath !== `profile_photos/${uid}/avatar.jpg`) {
    throw new HttpsError("invalid-argument", "Invalid profile photo path.");
  }

  let birthday = null;

  if (p.dob) {
    const dateText = String(p.dob);
    const parsed = new Date(`${dateText}T00:00:00Z`);

    if (
      !/^\d{4}-\d{2}-\d{2}$/.test(dateText) ||
      !Number.isFinite(parsed.getTime()) ||
      parsed.toISOString().slice(0, 10) !== dateText ||
      parsed.getTime() > Date.now()
    ) {
      throw new HttpsError(
        "invalid-argument",
        "Enter a valid date of birth (YYYY-MM-DD).",
      );
    }

    birthday = admin.firestore.Timestamp.fromDate(parsed);
  }

  const db = admin.firestore();
  const FV = admin.firestore.FieldValue;

  const userRef = db.collection("users").doc(uid);
  const nameRef = db.collection("usernames").doc(username);
  const draftRef = db.collection("onboarding_drafts").doc(uid);

  return await db.runTransaction(async (tx) => {
    // All reads occur before any writes.
    const nameSnap = await tx.get(nameRef);
    const userSnap = await tx.get(userRef);

    if (nameSnap.exists && nameSnap.data().uid !== uid) {
      throw new HttpsError("already-exists", "That username is already taken.");
    }

    if (userSnap.exists && userSnap.data().onboardingComplete === true) {
      return { ok: true, alreadyCompleted: true };
    }

    const role = userSnap.data()?.role;

    if (role !== "coach" && role !== "client") {
      throw new HttpsError(
        "failed-precondition",
        "Choose Coach or Client before completing your profile.",
      );
    }
    let coachRef = null;
    let coachId = null;
    let invitationRef = null;
    let invitation = null;
    let relationshipRef = null;
    let relationshipSnap = null;

    // The coach is optional.
    if (role === "client" && inviteCode) {
      const inviteQuery = db
        .collection("invitations")
        .where("code", "==", inviteCode)
        .limit(1);

      const inviteResults = await tx.get(inviteQuery);

      if (inviteResults.empty) {
        throw new HttpsError("not-found", "The coach code is invalid.");
      }

      const inviteSnap = inviteResults.docs[0];
      invitationRef = inviteSnap.ref;
      invitation = inviteSnap.data();

      if (invitation.status !== "active") {
        throw new HttpsError(
          "failed-precondition",
          "This invitation is not active.",
        );
      }

      coachRef = invitation.coach;

      if (
        !coachRef ||
        typeof coachRef.path !== "string" ||
        !/^users\/[^/]+$/.test(coachRef.path)
      ) {
        throw new HttpsError(
          "failed-precondition",
          "This invitation has no valid coach.",
        );
      }

      coachId = coachRef.id;

      if (coachId === uid) {
        throw new HttpsError(
          "failed-precondition",
          "You cannot join yourself as a coach.",
        );
      }

      if (
        invitation.expiresAt &&
        invitation.expiresAt.toMillis() < Date.now()
      ) {
        throw new HttpsError(
          "failed-precondition",
          "This invitation has expired.",
        );
      }

      relationshipRef = db.collection("coach_clients").doc(`${coachId}_${uid}`);

      relationshipSnap = await tx.get(relationshipRef);

      const maxUses = invitation.maxUses;
      const useCount = invitation.useCount || 0;

      if (
        !relationshipSnap.exists &&
        Number.isInteger(maxUses) &&
        maxUses > 0 &&
        useCount >= maxUses
      ) {
        throw new HttpsError(
          "resource-exhausted",
          "This invitation has reached its limit.",
        );
      }
    }

    // Reserve username.
    tx.set(nameRef, {
      uid,
      reservedAt: FV.serverTimestamp(),
    });

    // Complete the profile using the role already saved in Firestore.
    const userData = {
      uid,
      display_name: fullName,
      username,
      username_lower: username,
      role,
      onboardingComplete: true,
      onboardingStep: "complete",
      onboarding_status: "complete",
      onboarding_completed_at: FV.serverTimestamp(),
    };

    if (role === "client") {
      userData.coach = coachRef;
    }

    if (photoPath) {
      userData.profilePhotoPath = photoPath;
    }

    tx.set(userRef, userData, { merge: true });

    // Save optional birthday privately.
    if (birthday) {
      tx.set(
        userRef.collection("private").doc("fitness"),
        {
          birthday,
          updated_at: FV.serverTimestamp(),
        },
        { merge: true },
      );
    }

    // Only link a coach when a code was provided.
    if (coachRef && !relationshipSnap.exists) {
      tx.set(relationshipRef, {
        coach: coachRef,
        client: userRef,
        coach_id: coachId,
        client_id: uid,
        invitation: invitationRef,
        status: "active",
        joined_at: FV.serverTimestamp(),
      });

      tx.update(invitationRef, {
        useCount: FV.increment(1),
      });

      tx.set(
        db.collection("notifications").doc(`client_joined_${coachId}_${uid}`),
        {
          recipient: coachRef,
          recipient_id: coachId,
          client: userRef,
          type: "client_joined",
          title: "New client joined!",
          body: `${fullName} joined your training space.`,
          read: false,
          created_at: FV.serverTimestamp(),
        },
      );
    }

    tx.delete(draftRef);

    return {
      ok: true,
      coachId,
      onboardingPath: coachId ? "join_trainer" : "skip_trainer",
    };
  });
});
