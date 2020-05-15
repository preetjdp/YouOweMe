import * as admin from "firebase-admin"

admin.initializeApp()

const firestore = admin.firestore()
const auth = admin.auth()
const fcm = admin.messaging()

interface sendFcmNotificationInterface {
    deviceToken: string
    title: string
    body: string,
    meta: object
}

const sendFcmNotification = ({ deviceToken, title, body, meta }: sendFcmNotificationInterface) => {
    return fcm.sendToDevice(deviceToken, {
        data: {
            title: title,
            body: body,
            ...meta
        }
    })
}

export {
    firestore,
    auth,
    sendFcmNotification
}