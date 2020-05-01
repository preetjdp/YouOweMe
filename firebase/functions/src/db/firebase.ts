import * as admin from "firebase-admin"

admin.initializeApp()

const firestore = admin.firestore()
const auth = admin.auth()
const fcm = admin.messaging()

interface sendFcmNotificationInterface {
    deviceToken: string
    title: string
    body: string
}

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