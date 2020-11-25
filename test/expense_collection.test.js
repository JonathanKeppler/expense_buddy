const helper = require("./test_helper.js")
const getFirestore = (auth) => {return helper.getFirestore(auth)};
const getAdminFirestore = () => {return helper.getAdminFirestore()};
const expId = "global_expense";

beforeEach(async () => {
    const admin = getAdminFirestore();
    const setupUser = admin.collection("users").doc(myId);
    await setupUser.set({linkedUsers: [theirId]});
});

describe("Expense Collection", () => {

    it("Can't create an expense if not logged in", async() => {
        const db = getFirestore(null);
        await firebase.assertFails(db.collection("expenses").add({type: "Food"}));
    });

    it("Can't create an expense if user is not logged in but part of scopedUsers", async() => {
        const db = getFirestore(null);
        await firebase.assertFails(db.collection("expenses").add({scopedUsers: [myId]}));
    });

    it("Can't create an expense with a scoped user outside of the user and linked users", async() => {
        const db = getFirestore(myAuth);
        await firebase.assertFails(db.collection("expenses").add({scopedUsers: [invalidId]}));
    });

    it("Can create an expense if user is logged in and part of scopedUsers", async() => {
        const db = getFirestore(myAuth);
        await firebase.assertSucceeds(db.collection("expenses").add({scopedUsers: [myId]}));
    });

    //TODO: would expect this to fail, but possible proof that before/after check on scopedUsers passes when before is null
    it("Can create an expense if user is logged in and part of scopedUsers", async() => {
        const db = getFirestore(myAuth);
        const createExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(createExp.set({scopedUsers: [theirId]}));
    });

    it("Can't edit an expense if user is not part of scopedUsers", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.update({cost: "13.37"}));
    });

    it("Can edit an expense if user is part of scopedUsers", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(readExp.update({cost: "13.37"}));
    });

    it("Can't change scopedUsers on an expense", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId, theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.update({scopedUsers: [theirId]}));
    });

    // //TODO: not working as intended, possible myId is still in the request.resource object
    // //will just go the linked user route
    // it("Can't edit an expense if user is not part of updated users", async() => {
    //     const admin = getAdminFirestore();
    //     const setupExp = admin.collection("expenses").doc(expId);
    //     await setupExp.set({users: [myId, theirId]});

    //     const db = getFirestore(myAuth);
    //     const readExp = db.collection("expenses").doc(expId);

    //     await readExp.update({users: firebase.firestore.FieldValue.arrayRemove(myId)});
        
    //     const updatedDoc = db.collection("expenses").doc(expId);
    //     const doc = await updatedDoc.get();
    //     console.log(doc.data());

    //     await firebase.assertSucceeds(readExp.update({cost: "13.37", 
    //     users: firebase.firestore.FieldValue.arrayRemove(myId)}));
    // });

    // //TODO: same as above
    // it("Can edit an expense only if user is part of updated users", async() => {
    //     const admin = getAdminFirestore();
    //     const setupExp = admin.collection("expenses").doc(expId);
    //     await setupExp.set({users: [myId]});

    //     const db = getFirestore(myAuth);
    //     const readExp = db.collection("expenses").doc(expId);
    //     await firebase.assertSucceeds(readExp.update({cost: "13.37", users: [myId]}));
    // });

    it("Can't read an expense if user is not part of users", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [theirId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertFails(readExp.get());
    });

    it("Can read an expense if user is part of users", async() => {
        const admin = getAdminFirestore();
        const setupExp = admin.collection("expenses").doc(expId);
        await setupExp.set({scopedUsers: [myId]});

        const db = getFirestore(myAuth);
        const readExp = db.collection("expenses").doc(expId);
        await firebase.assertSucceeds(readExp.get());
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

    //TODO: Can't create an expense with user other than self and linked users
})