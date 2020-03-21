import {initializeApp, credential} from "firebase-admin"

import serviceAccountJson from '../../secrets/firebase-admin-key.json'

initializeApp({
    credential: credential.cert({
        projectId: serviceAccountJson.project_id,
        privateKey: serviceAccountJson.private_key,
        clientEmail: serviceAccountJson.client_email
    }),
    databaseURL: "https://youoweme-6c622.firebaseio.com"
})