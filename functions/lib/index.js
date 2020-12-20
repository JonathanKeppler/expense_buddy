"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.newUserSignup = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

//auth trigger - new user signup
exports.newUserSignup = functions.auth.user().onCreate((user) => {
    return admin.firestore().collection('users').doc(user.uid).set({
        email: user.email,
    });
});

exports.copyGlobalDocs = functions.auth.user().onCreate((user) => {
    const globalExpenses = admin.firestore().collection('expensesTypes').where("isScoped", "==", true);
})
