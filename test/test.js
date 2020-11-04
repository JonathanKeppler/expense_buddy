const assert = require('assert');
const firebase = require('@firebase/testing');

const MY_PROJECT_ID = "expense-buddy-8c526";
const myId = "user_abc";
const theirId = "user_xyz";
const myAuth = {uid: myId, email: "abc@gmail.com"};

function getFirestore(auth) {
    return firebase.initializeTestApp({projectId: MY_PROJECT_ID, auth: auth}).firestore();
}

function getAdminFirestore() {
    return firebase.initializeAdminApp({projectId: MY_PROJECT_ID}).firestore();
}

beforeEach(async () => {
    await firebase.clearFirestoreData({projectId: MY_PROJECT_ID});
});

describe("Expense Buddy", () => {


    /*********************
     **  EXPENSE TYPES  **
     *********************/
    it("Can't read all items in the expenseTypes collection", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes");
        await firebase.assertFails(testQuery.get());
    })

    it("Can read items in the expenseTypes collection that are not scoped", async() => {
        const db = getFirestore(null);
        const testQuery = db.collection("expenseTypes").where("isScoped", "==", false);
        await firebase.assertSucceeds(testQuery.get());
    });

    it("Can query items in the expenseTypes collection that are scoped and user is scopedUser", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes")
            .where("isScoped", "==", true)
            .where("scopedUsers", "array-contains", myId);
        await firebase.assertSucceeds(testQuery.get());
    });

    it("Can read item in the expenseTypes collection that are scoped and user is scopedUser", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "scoped_with_scopedUser";
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read item in the expenseTypes collection that are scoped and user is not scopedUser", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "scoped_without_scopedUser";
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(testRead.get());
    });


    /***************
     **   USERS   **
     ***************/
    it("Can write to a user document with the same ID as the user", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("users").doc(myId);
        await firebase.assertSucceeds(testDoc.set({foo: "bar"}));
    });

    it("Can't write to a user document with a different ID as the user", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("users").doc(theirId);
        await firebase.assertFails(testDoc.set({foo: "bar"}));
    });


    /****************
     **  EXPENSES  **
     ****************/
})