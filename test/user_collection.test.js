const helper = require("./test_helper.js")

const getFirestore = (auth) => {return helper.getFirestore(auth)};

const getAdminFirestore = () => {return helper.getAdminFirestore()};

describe("User Collection", () => {

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
})