import * as admin from "firebase-admin"

import serviceAccountJson from '../../secrets/firebase-admin-key.json'

admin.initializeApp({
    credential: admin.credential.cert({
        projectId: serviceAccountJson.project_id,
        privateKey: serviceAccountJson.private_key,
        clientEmail: serviceAccountJson.client_email
    }),
    databaseURL: "https://youoweme-6c622.firebaseio.com"
})

const firestore = admin.firestore()

export {
    firestore
}