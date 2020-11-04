const assert = require('assert');
const firebase = require('@firebase/testing');
const { isContext } = require('vm');

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

    it("Can't create a new expenseType if user is not logged in", async() => {
        const db = getFirestore(null);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({foo: "bar"}));
    });

    it("Can't create a new expenseType if user is logged in but not part of scopedUsers", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({scopedUsers: [theirId]}));
    });

    it("Can't create a new expenseType if user is not logged in but part of scopedUsers", async() => {
        const db = getFirestore(null);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({scopedUsers: [myId]}));
    });

    it("Can create a new expenseType if user is logged in and part of scopedUsers", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertSucceeds(testDoc.set({scopedUsers: [myId]}));
    });

    /*****************
     **  SUB TYPES  **
     *****************/
    it("Can read subTypes if parent expenseType is not scoped and subType is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const subTypeId = "global_sub_type";
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read subTypes if parent expenseType is not scoped and subType is scoped without user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const subTypeId = "global_sub_type";
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(testRead.get());
    });

    it("Can read subTypes if parent expenseType is scoped with user and subType is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const subTypeId = "global_sub_type";
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can read subTypes if parent expenseType is scoped with user and subType is scoped with user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const subTypeId = "global_sub_type";
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read subTypes if parent expenseType is scoped and user is not scopedUser", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc("testDoc");
        await firebase.assertFails(testRead.get());
    });

    it("Can create subTypes if parent expense is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: false}));
    });

    it("Can create subTypes if parent expense is scoped with user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: false}));
    });

    it("Can't create subTypes if parent expense is scoped without user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(setupSubType.set({isScoped: false}));
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

    it("Can read a user document with the same ID as the user", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("users").doc(myId);
        await firebase.assertSucceeds(testDoc.get());
    });

    it("Can't read a user document with a different ID as the user", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("users").doc(theirId);
        await firebase.assertFails(testDoc.get());
    });


    /****************
     **  EXPENSES  **
     ****************/
    it("Can't create an expense if not logged in", async() => {
        const expId = "expense_123";
        const db = getFirestore(null);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertFails(testDoc.set({type: "Food"}));
    });

    it("Can't create an expense if user is logged in but not part of user array", async() => {
        const expId = "expense_123";
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertFails(testDoc.set({users: [theirId]}));
    });

    it("Can't create an expense if user is not logged in but part of user array", async() => {
        const expId = "expense_123";
        const db = getFirestore(null);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertFails(testDoc.set({users: [myId]}));
    });

    it("Can create an expense if user is logged in and part of user array", async() => {
        const expId = "expense_123";
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(testDoc.set({users: [myId]}));
    });

    it("Can't edit an expense if user is not part of user array", async() => {
        const expId = "expense_123";
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertFails(testDoc.set({users: [theirId]}));
    });

    it("Can edit an expense if user is part of user array", async() => {
        const expId = "expense_123";
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(testDoc.set({users: [myId]}));
    });

    it("Can't read an expense if user is not part of user array", async() => {
        const admin = getAdminFirestore();
        const expId = "users_doc";
        const setupDoc = admin.collection("expenses").doc(expId);
        await setupDoc.set({users: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenses").doc(expId);
        await firebase.assertFails(testRead.get());
    });

    it("Can read an expense if user is part of user array", async() => {
        const admin = getAdminFirestore();
        const expId = "users_doc";
        const setupDoc = admin.collection("expenses").doc(expId);
        await setupDoc.set({users: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(testRead.get());
    });
})