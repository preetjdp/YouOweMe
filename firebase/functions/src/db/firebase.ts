import * as admin from "firebase-admin"

admin.initializeApp()

const firestore = admin.firestore()
const auth = admin.auth()

export {
    firestore,
    auth
}