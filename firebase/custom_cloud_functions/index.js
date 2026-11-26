const admin = require("firebase-admin/app");
admin.initializeApp();

const validateInvite = require("./validate_invite.js");
exports.validateInvite = validateInvite.validateInvite;
const checkUsername = require("./check_username.js");
exports.checkUsername = checkUsername.checkUsername;
const finalizeOnboarding = require("./finalize_onboarding.js");
exports.finalizeOnboarding = finalizeOnboarding.finalizeOnboarding;
const generateCoachCode = require("./generate_coach_code.js");
exports.generateCoachCode = generateCoachCode.generateCoachCode;
const listCoachClients = require("./list_coach_clients.js");
exports.listCoachClients = listCoachClients.listCoachClients;
