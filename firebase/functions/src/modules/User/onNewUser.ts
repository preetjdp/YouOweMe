import * as functions from "firebase-functions"
import { FieldValue } from "@google-cloud/firestore"
import { firestore } from "../../db/firebase"

/*
When a new user is created the system guarentees presenece of two things
1. displayName
2. mobileNo
*/

const onNewUser = functions
    .auth.user().onCreate(async (user: functions.auth.UserRecord) => {
        const userId = user.uid
        const userRef = firestore
            .collection('users')
            .doc(userId)

        await userRef.set({
            name: user.displayName!,
            mobile_no: user.phoneNumber,
            created: FieldValue.serverTimestamp()
        }, {
            merge: true
        })
    })

export { onNewUser }

