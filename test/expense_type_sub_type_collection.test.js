const helper = require("./test_helper.js")
const getFirestore = (auth) => {return helper.getFirestore(auth)};
const getAdminFirestore = () => {return helper.getAdminFirestore()};

describe("Expense Sub Types", () => {

    it("Can read subTypes if parent expenseType is not scoped and subType is not scoped", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read subTypes if parent expenseType is not scoped and subType is scoped without user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(testRead.get());
    });

    it("Can read subTypes if parent expenseType is not scoped and subType is scoped with user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can read subTypes if parent expenseType is scoped with user and subType is not scoped", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't read subTypes if parent expenseType is scoped with user and subType is scoped without user", async() => {
        const admin = getAdminFirestore();
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [myId]});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc("testDoc");
        await firebase.assertFails(testRead.get());
    });

    it("Can read subTypes if parent expenseType is scoped with user and subType is scoped with user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(testRead.get());
    });

    it("Can't create a new expenseType if user is not logged in", async() => {
        const db = getFirestore(null);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({foo: "bar"}));
    });

    it("Can't create subTypes with scoped user other than user or linked users", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(setupSubType.set({isScoped: true, scopedUsers: [invalidId]}));
    });

    it("Can't create subTypes if parent expense is scoped without user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(setupSubType.set({isScoped: false}));
    });

    it("Can create subTypes if parent expense is not scoped and subType is scoped with user or linked users", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: true, scopedUsers: [myId]}));
    });

    it("Can create subTypes if parent expense is scoped with user and subtype is scoped with user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: true, scopedUsers: [myId]}));
    });

    it("Can't edit scoped users on a sub type", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});
        
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const updateSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(updateSubType.update({scopedUsers: theirId}));
    });

    it("Can't edit a subType if it is not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});
        
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const updateSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(updateSubType.update({isScoped: false}));
    });

    it("Can edit a subType if it is scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});
        
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const updateSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(updateSubType.update({isScoped: false}));
    });

    it("Can't delete a subType if it is not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});
        
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const deleteSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(deleteSubType.delete());
    });

    it("Can delete a subType if it is scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});
        
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const deleteSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(deleteSubType.delete());
    });

})