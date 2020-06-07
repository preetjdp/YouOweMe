import * as admin from "firebase-admin"
import { PROJECT_ID, CLIENT_EMAIL, PRIVATE_KEY } from '../utils/envConfig'
import { configureForLocalFirebase } from "../utils/localFirebaseConfig"

admin.initializeApp({
    credential: admin.credential.cert({
        projectId: PROJECT_ID,
        privateKey: PRIVATE_KEY,
        clientEmail: CLIENT_EMAIL
    }),
    databaseURL: "https://youoweme-6c622.firebaseio.com",
    storageBucket: "youoweme-6c622.appspot.com"
})

const firestore = admin.firestore()
const auth = admin.auth()
const storageBucket = admin.storage().bucket()
configureForLocalFirebase()
export {
    firestore,
    auth,
    storageBucket
}