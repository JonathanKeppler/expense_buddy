const helper = require("./test_helper.js")
const getFirestore = (auth) => {return helper.getFirestore(auth)};
const getAdminFirestore = () => {return helper.getAdminFirestore()};

describe("Expense Type Collection", () => {

    it("Can't read all items in the expenseTypes collection", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes");
        await firebase.assertFails(testQuery.get());
    })

    it("Can read items in the expenseTypes collection that are not scoped", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes").where("isScoped", "==", false);
        await firebase.assertSucceeds(testQuery.get());
    });

    it("Can query items in the expenseTypes collection that are scoped to user", async() => {
        const db = getFirestore(myAuth);
        const testQuery = db.collection("expenseTypes")
            .where("isScoped", "==", true)
            .where("scopedUsers", "array-contains", myId);
        await firebase.assertSucceeds(testQuery.get());
    });

    it("Can read item in the expenseTypes collection that are scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read item in the expenseTypes collection that are not scoped to user", async() => {
        const admin = getAdminFirestore();
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

    it("Can't create a new expenseType with a scoped user other than user and linked users", async() => {
        const db = getFirestore(myAuth);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({scopedUsers: [invalidId]}));
    });

    it("Can create a new expenseType if user is logged in and scoped", async() => {
        const db = getFirestore(myAuth);
        await firebase.assertSucceeds(db.collection("expenseTypes").add({scopedUsers: [myId]}));
    });

    it("Can't edit scoped users on an expense type", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({scopedUsers: [myId, theirId]});

        const db = getFirestore(myAuth);
        const readExpType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(readExpType.update({scopedUsers: [theirId]}));
    });

    it("Can't edit an expenseType not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const updateExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(updateExType.update({isScoped: false}));
    });

    it("Can edit an expenseType scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const updateExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(updateExType.update({isScoped: false}));
    });

    it("Can't delete an expenseType that is not scoped", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(deleteExType.delete());
    });

    it("Can't delete an expenseType that is scoped not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertFails(deleteExType.delete());
    });

    it("Can delete an expenseType that is scoped and user is scoped", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const deleteExType = db.collection("expenseTypes").doc(exTypeId);
        await firebase.assertSucceeds(deleteExType.delete());
    });

})