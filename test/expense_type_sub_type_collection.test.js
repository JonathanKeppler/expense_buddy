const helper = require("./test_helper.js")

const getFirestore = (auth) => {return helper.getFirestore(auth)};

const getAdminFirestore = () => {return helper.getAdminFirestore()};

describe("Expense Sub Types", () => {

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

    it("Can't read subTypes if parent expenseType is scoped with user and subType is scoped without user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupDoc = admin.collection("expenseTypes").doc(exTypeId);
        await setupDoc.set({isScoped: true, scopedUsers: [myId]});

        const subTypeId = "global_sub_type";
        const setupSubType = admin.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await setupSubType.set({isScoped: true, scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const testRead = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc("testDoc");
        await firebase.assertFails(testRead.get());
    });

    it("Can create subTypes if parent expense is not scoped and subType is scoped with user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: true, scopedUsers: [myId]}));
    });

    it("Can create subTypes if parent expense is scoped with user and subtype is scoped with user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: true, scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertSucceeds(setupSubType.set({isScoped: true, scopedUsers: [myId]}));
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

    it("Can't create subTypes if subtype is scoped without user", async() => {
        const admin = getAdminFirestore();
        const exTypeId = "gobal_expense_type";
        const setupExType = admin.collection("expenseTypes").doc(exTypeId);
        await setupExType.set({isScoped: false});

        const db = getFirestore(myAuth);
        const subTypeId = "global_sub_type";
        const setupSubType = db.collection("expenseTypes").doc(exTypeId).collection("expenseTypeSubTypes").doc(subTypeId);
        await firebase.assertFails(setupSubType.set({isScoped: true, scopedUsers: [theirId]}));
    });


    it("Can't create a new expenseType if user is not logged in", async() => {
        const db = getFirestore(null);
        const testDoc = db.collection("expenseTypes").doc("test_doc");
        await firebase.assertFails(testDoc.set({foo: "bar"}));
    });

})