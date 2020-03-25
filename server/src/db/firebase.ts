import * as admin from "firebase-admin"
import {PROJECT_ID, CLIENT_EMAIL, PRIVATE_KEY} from '../utils/envConfig'

admin.initializeApp({
    credential: admin.credential.cert({
        projectId: PROJECT_ID,
        privateKey: PRIVATE_KEY,
        clientEmail: CLIENT_EMAIL
    }),
    databaseURL: "https://youoweme-6c622.firebaseio.com"
})

const firestore = admin.firestore()

export {
    firestore
}