import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
admin.initializeApp();

//auth trigger - new user signup
export const newUserSignup = functions.auth.user().onCreate((user) => {
  return admin.firestore().collection('users').doc(user.uid).set({
    email: user.email,
  });
});
