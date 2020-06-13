import * as functions from "firebase-functions"

import { DocumentSnapshot, DocumentReference } from "@google-cloud/firestore"
import { sendMessage } from "../../db/twilio"
import { sendFcmNotification } from "../../db/firebase"
import { getPermalinkFromOwe } from "../../utils/helpers"

/**
* 1. Send the request to the the person IssuedTo
*    * This can be Fcm Notifications If the Fcm Id is present.
*    * Sms If Not Present.
 */

const onNewOwe = functions.firestore.document('users/{issuedById}/owes/{oweId}')
    .onCreate(async (snapshot, context) => {
        sendNotificationToOweIssuedTo(snapshot)
    })

const sendNotificationToOweIssuedTo = async (oweSnapshot: DocumentSnapshot) => {
    const oweRef = oweSnapshot.ref
    const oweData = oweSnapshot.data()

    let oweAmount: number = oweData!.amount

    const issuedByRef = oweRef.parent.parent
    let issuedBySnapshot = await issuedByRef!.get()
    let issuedByData = issuedBySnapshot.data()
    let issuedByName: string = issuedByData!.name

    const issuedToRef: DocumentReference = oweData!.issuedToRef
    let issuedToSnapshot = await issuedToRef.get()
    let issuedToData = issuedToSnapshot.data()

    let mobileNo: string = issuedToData!.mobile_no
    let issuedToName: string = issuedToData!.name
    let issuedToFcmToken: string | undefined = issuedToData!.fcm_token

    // let message = `Psst. ${issuedToName} It seems that you owe ${issuedByName} ₹${oweAmount}. Click on the link to accept or decline the transaction.`
    let message = `Psst. ${issuedToName} It seems that you owe ${issuedByName} ₹${oweAmount}.`

    if (issuedToFcmToken) {
        console.log("Sending FCM Notification")
        return await sendFcmNotification({
            deviceToken: issuedToFcmToken,
            title: "New Owe Alert",
            body: message
        })
    }
    console.log("Sending SMS")
    const permalink = await getPermalinkFromOwe(oweSnapshot)
    message += `\n${permalink}`
    return sendMessage({ message, mobileNo })
}

export {
    onNewOwe
}