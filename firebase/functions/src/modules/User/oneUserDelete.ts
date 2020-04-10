import * as functions from "firebase-functions"
import { QuerySnapshot } from "@google-cloud/firestore"
import { firestore } from "../../db/firebase"

/*
Steps Performed When the user is deleted.
1. Delete All the owes in which the user is present. // THis have to be changed in the future.
2. Delete the user Document.
*/

const onUserDelete = functions
    .auth.user().onDelete(async (user: functions.auth.UserRecord) => {
        const userId = user.uid
        const userRef = firestore
            .collection('users')
            .doc(userId)

        // Find all the owes assigned to the user.
        const userOwesQuery = firestore
            .collectionGroup('owes')
            .where('issuedToRef', "==", userRef)

        const owes: QuerySnapshot = await userOwesQuery.get()
        owes.forEach(async (owe) => {
            await owe.ref.delete()
        })

        // Delete the user Document   
        await userRef.delete()
    })

export { onUserDelete }

