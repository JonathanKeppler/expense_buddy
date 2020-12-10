"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.newUserSignup = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
//auth trigger - new user signup
exports.newUserSignup = functions.auth.user().onCreate((user) => {
    return admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
    });
});
//# sourceMappingURL=index.js.map