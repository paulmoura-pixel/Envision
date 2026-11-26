const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { getFirestore } = require("firebase-admin/firestore");

exports.listCoachClients = onCall(
  { region: "us-central1" },
  async (request) => {
    const uid = request.auth?.uid;
    if (!uid) {
      throw new HttpsError("unauthenticated", "Sign in first.");
    }

    const db = getFirestore();
    const users = db.collection("users");
    const coachRef = users.doc(uid);
    const coach = await coachRef.get();
    if (coach.get("role") !== "coach") {
      throw new HttpsError("permission-denied", "Coach access is required.");
    }

    const links = await db
      .collection("coach_clients")
      .where("coach_id", "==", uid)
      .where("status", "==", "active")
      .get();

    const clientIds = new Set();
    for (const link of links.docs) {
      const data = link.data();
      const id = data.client_id;
      if (
        typeof id === "string" &&
        id &&
        id !== uid &&
        !id.includes("/") &&
        data.coach?.path === coachRef.path &&
        data.client?.path === `users/${id}`
      ) {
        clientIds.add(id);
      }
    }

    if (clientIds.size === 0) return { clients: [] };

    const profiles = await db.getAll(
      ...Array.from(clientIds, (id) => users.doc(id)),
      { fieldMask: ["display_name", "photo_url"] },
    );

    const clients = profiles
      .filter((profile) => profile.exists)
      .map((profile) => {
        const name = profile.get("display_name");
        const photo = profile.get("photo_url");
        return {
          id: profile.id,
          display_name: typeof name === "string" ? name : "",
          photo_url: typeof photo === "string" ? photo : "",
        };
      });

    return { clients };
  },
);
