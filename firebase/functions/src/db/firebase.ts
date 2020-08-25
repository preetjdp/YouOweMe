import * as admin from "firebase-admin"

admin.initializeApp()

const firestore = admin.firestore()
const auth = admin.auth()
const fcm = admin.messaging()

/**
 * This is the interface for the  `sendFcmNotification` function
 *  */
interface sendFcmNotificationInterface {
    deviceToken: string
    title: string
    body: string
}

/**
 * Send Notifications to people using this abstracted function.
 * 
 * @param deviceToken
 * The fcm token for the device that the
 * notification is supposed to be sent to
 * 
 * @param title
 * The title of the notification
 * 
 * @returns Function
 */
const sendFcmNotification = ({ deviceToken, title, body }: sendFcmNotificationInterface) => {
    return fcm.sendToDevice(deviceToken, {
        notification: {
            title: title,
            body: body
        }
    })
}

export {
    firestore,
    auth,
    sendFcmNotification
}