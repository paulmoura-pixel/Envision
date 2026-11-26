const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
const { randomInt } = require("node:crypto");

const alphabet = "ABCDEFGHJKLMNPQRSTUVWXYZ23456789";

exports.generateCoachCode = functions
  .region("us-central1")
  .https.onCall(async (_data, context) => {
    const uid = context.auth?.uid;
    if (!uid) {
      throw new functions.https.HttpsError("unauthenticated", "Sign in first.");
    }

    const db = admin.firestore();
    const coachRef = db.collection("users").doc(uid);
    const invitations = db.collection("invitations");

    return db.runTransaction(async (tx) => {
      const profile = await tx.get(coachRef);
      const coach = profile.data();
      if (coach?.role !== "coach") {
        throw new functions.https.HttpsError(
          "permission-denied",
          "Your profile must have the Coach role.",
        );
      }

      if (coach.coachCode) {
        const existing = await tx.get(
          invitations.where("code", "==", coach.coachCode).limit(2),
        );
        const invite = existing.docs[0]?.data();
        if (
          existing.size === 1 &&
          invite?.coach?.path === coachRef.path &&
          invite.status === "active"
        ) {
          return coach.coachCode;
        }
        throw new functions.https.HttpsError(
          "failed-precondition",
          "Your saved code needs to be reviewed.",
        );
      }

      for (let attempt = 0; attempt < 6; attempt += 1) {
        const code = Array.from(
          { length: 8 },
          () => alphabet[randomInt(alphabet.length)],
        ).join("");
        const inviteRef = invitations.doc(code);
        const reservation = await tx.get(inviteRef);
        const legacy = await tx.get(
          invitations.where("code", "==", code).limit(1),
        );
        if (reservation.exists || !legacy.empty) continue;

        tx.create(inviteRef, {
          code,
          coach: coachRef,
          coachName: coach.display_name || "",
          gymName: coach.gymName || "",
          gymPhoto: coach.gymImage || "",
          status: "active",
          useCount: 0,
        });
        tx.update(coachRef, { coachCode: code });
        return code;
      }

      throw new functions.https.HttpsError(
        "resource-exhausted",
        "Could not reserve a code. Please try again.",
      );
    });
  });
