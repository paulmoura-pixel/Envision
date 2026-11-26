const { onCall, HttpsError } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

// Do not call admin.initializeApp() in FlutterFlow.

exports.validateInvite = onCall({ region: "us-central1" }, async (request) => {
  const uid = request.auth?.uid;

  if (!uid) {
    throw new HttpsError("unauthenticated", "Sign in required.");
  }

  const codeIn = String(request.data?.code || "")
    .trim()
    .toUpperCase()
    .replace(/[^A-Z0-9]/g, "");

  if (codeIn.length < 4) {
    throw new HttpsError("invalid-argument", "Enter your coach code.");
  }

  const db = admin.firestore();

  const qs = await db
    .collection("invitations")
    .where("code", "==", codeIn)
    .limit(1)
    .get();

  if (qs.empty) {
    throw new HttpsError("not-found", "That coach code is not valid.");
  }

  const d = qs.docs[0].data();

  if (d.status !== "active") {
    throw new HttpsError(
      "failed-precondition",
      "This invitation is not active.",
    );
  }

  if (d.expiresAt && d.expiresAt.toMillis() < Date.now()) {
    throw new HttpsError("failed-precondition", "This invitation has expired.");
  }

  if (!d.coach || !d.coach.id) {
    throw new HttpsError(
      "failed-precondition",
      "Invitation has no valid coach.",
    );
  }

  const coachId = d.coach.id;

  if (coachId === uid) {
    throw new HttpsError(
      "failed-precondition",
      "You cannot join your own training space.",
    );
  }

  if (d.maxUses && (d.useCount || 0) >= d.maxUses) {
    const rel = await db
      .collection("coach_clients")
      .doc(`${coachId}_${uid}`)
      .get();

    if (!rel.exists) {
      throw new HttpsError(
        "resource-exhausted",
        "This invitation has reached its limit.",
      );
    }
  }

  return {
    code: codeIn,
    coachId,
    coachName: d.coachName || "",
    coachPhoto: d.coachPhoto || "",
    coachRole: d.coachRole || "Personal Trainer",
    gymId: d.gymId || "",
    gymName: d.gymName || "",
    gymLocation: d.gymLocation || "",
    gymPhoto: d.gymPhoto || "",
  };
});
