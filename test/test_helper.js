const assert = require('assert');
const firebase = require('@firebase/testing');
const { isContext } = require('vm');

const MY_PROJECT_ID = "expense-buddy-8c526";
const myId = "user_abc";
const theirId = "user_xyz";
const invalidId = "user_invalid";
const myAuth = {uid: myId, email: "abc@gmail.com"};

global.assert = assert;
global.firebase = firebase;
global.isContext = isContext;
global.MY_PROJECT_ID = MY_PROJECT_ID;
global.myId = myId;
global.theirId = theirId;
global.invalidId = invalidId;
global.myAuth = myAuth;

const getFirestore = (auth) => {
    return firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: auth}).firestore();
}

const getAdminFirestore = () => {
    return firebase.initializeAdminApp({projectId: MY_PROJECT_ID}).firestore();
}

beforeEach(async () => {
    await firebase.clearFirestoreData({projectId: MY_PROJECT_ID});
});

module.exports.getFirestore = getFirestore;
module.exports.getAdminFirestore = getAdminFirestore;