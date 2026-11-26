const { onCall, HttpsError } = require("firebase-functions/v2/https");
const admin = require("firebase-admin");

// Do not call admin.initializeApp() in FlutterFlow.

exports.checkUsername = onCall({ region: "us-central1" }, async (request) => {
  const uid = request.auth?.uid;

  if (!uid) {
    throw new HttpsError("unauthenticated", "Sign in required.");
  }

  const username = String(request.data?.username || "")
    .trim()
    .replace(/^@/, "")
    .toLowerCase();

  if (!/^[a-z0-9_.]{3,24}$/.test(username) || username.includes("..")) {
    return {
      available: false,
      reason: "invalid",
    };
  }

  const snap = await admin
    .firestore()
    .collection("usernames")
    .doc(username)
    .get();

  const available = !snap.exists || snap.data().uid === uid;

  return {
    available,
    reason: available ? "" : "taken",
  };
});
