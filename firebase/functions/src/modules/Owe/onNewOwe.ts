import * as functions from "firebase-functions"

import { DocumentSnapshot, DocumentReference } from "@google-cloud/firestore"
import { sendMessage } from "../../db/twilio"

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

    let message = `Psst. ${issuedToName} It seems that you owe ${issuedByName} ₹${oweAmount}.
    Click on the link to accept or decline the transaction.`

    sendMessage(message, mobileNo)
    return
}

export {
    onNewOwe
}