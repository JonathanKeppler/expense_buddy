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

describe("Expense Type Collection", () => {

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

    it("Can query items in the expenseTypes collection that are scoped and user is scoped", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes")
            .where("isScoped", "==", true)
            .where("scopedUsers", "array-contains", myId);
        await firebase.assertSucceeds(testQuery.get());
    });

    it("Can read item in the expenseTypes collection that are scoped and user is scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "scoped_with_scopedUser";
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read item in the expenseTypes collection that are scoped and user is scoped", async() => {
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

    it("Can't create a new expenseType if user is logged in but not scoped", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({scopedUsers: [theirId]}));
    });

    it("Can't create a new expenseType if user is not logged in but scoped", async() => {
        const db = getFirestore(null);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({scopedUsers: [myId]}));
    });

    it("Can create a new expenseType if user is logged in and scoped", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertSucceeds(testDoc.set({scopedUsers: [myId]}));
    });

    it("Can't edit an expenseType that is not scoped to user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const updateExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(updateExType.update({isScoped: true}));
    });

    it("Can't edit an expenseType if user is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const updateExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(updateExType.update({isScoped: false}));
    });

    it("Can edit an expenseType if user is scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const updateExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(updateExType.update({isScoped: false}));
    });

    it("Can't delete an expenseType that is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(deleteExType.delete());
    });

    it("Can't delete an expenseType that is scoped but user is not scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(deleteExType.delete());
    });

    it("Can delete an expenseType that is scoped and user is scoped", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(deleteExType.delete());
    });

})