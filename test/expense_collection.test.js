const helper = require("./test_helper.js")
const getFirestore = (auth) => {return helper.getFirestore(auth)};
const getAdminFirestore = () => {return helper.getAdminFirestore()};

describe("Expense Collection", () => {

    it("Can't read an expense if not logged in", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(null);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.get());
    });

    it("Can't read an expense if user is not sccoped", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.get());
    });

    it("Can read an expense if user is scoped", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(readExp.get());
    });

    it("Can't create an expense if not logged in", async() => {
        const db = getFirestore(null);
        await firebase.assertFails(db.collection("expenses").add({type: "Food"}));
    });

    it("Can't create an expense if user is not logged in", async() => {
        const db = getFirestore(null);
        await firebase.assertFails(db.collection("expenses").add({scopedUsers: [myId]}));
    });

    it("Can't create an expense with a scoped user other than the user and linked users", async() => {
        const db = getFirestore(myAuth);
        await firebase.assertFails(db.collection("expenses").add({scopedUsers: [invalidId]}));
    });

    it("Can create an expense if user is logged in scoped", async() => {
        const db = getFirestore(myAuth);
        await firebase.assertSucceeds(db.collection("expenses").add({scopedUsers: [myId]}));
    });

    it("Can't edit scoped users on an expense", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId, theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.update({scopedUsers: [theirId]}));
    });

    it("Can't edit an expense not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.update({cost: "13.37"}));
    });

    it("Can edit an expense scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(readExp.update({cost: "13.37"}));
    });

    it("Can't delete an expense that is not scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const deleteExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(deleteExp.delete());
    });

    it("Can delete an expense that is scoped to user", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const deleteExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(deleteExp.delete());
    });

})