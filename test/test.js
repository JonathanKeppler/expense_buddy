const assert = require('assert');
const firebase = require('@firebase/testing');

const MY_PROJECT_ID = "expense-buddy-8c526";

describe("Expense Buddy", () => {

    it("Understands basic math", () => {
        assert.strictEqual(2+2, 4);
    })

    it("Can read items in the expenseType collection", async () => {
        const db = firebase.initializeTestApp({projectId: MY_PROJECT_ID}).firestore();
        const testDoc = db.collection("ExpenseTypes").doc("testDoc");
        await firebase.assertSucceeds(testDoc.get());
    })
})