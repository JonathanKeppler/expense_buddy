const assert = require('assert');
const settings = require("../appconfig.settings.json")
const firebase = require('@firebase/testing');
const { isContext } = require('vm');

const MY_PROJECT_ID = settings.projectId;
const myId = "user_abc";
const theirId = "user_xyz";
const invalidId = "user_invalid";
const myAuth = {uid: myId, email: "abc@gmail.com"};
const expId = "global_expense";
const exTypeId = "global_expense_type";
const subTypeId = "global_expense_sub_type";

global.assert = assert;
global.firebase = firebase;
global.isContext = isContext;
global.MY_PROJECT_ID = MY_PROJECT_ID;
global.myId = myId;
global.theirId = theirId;
global.invalidId = invalidId;
global.myAuth = myAuth;
global.expId = expId;
global.exTypeId = exTypeId;
global.subTypeId = subTypeId;

const getFirestore = (auth) => {
    return firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: auth}).firestore();
}

const getAdminFirestore = () => {
    return firebase.initializeAdminApp({projectId: MY_PROJECT_ID}).firestore();
}

beforeEach(async () => {
    await firebase.clearFirestoreData({projectId: MY_PROJECT_ID});

    const admin = getAdminFirestore();
    const setupUser = admin.collection("users").doc(myId);
    await setupUser.set({linkedUsers: [theirId]});
});

module.exports.getFirestore = getFirestore;
module.exports.getAdminFirestore = getAdminFirestore;