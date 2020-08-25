import axios from "axios"
import { firestore } from "../db/firebase"

const firebaseHost = "localhost"
const firebasePort = "8080"

/**
 * This function configues the use
 * of the local firestore if it is running on
 * the specified port.
 */
const configureForLocalFirebase = async () => {
    const useLocalFirebase = await checkForLocalFirebase()
    if (useLocalFirebase) {
        firestore.settings({
            host: firebaseHost,
            ssl: false,
            port: 8080,
            customHeaders: {
                "Authorization": "Bearer owner"
            }
        })
    }
}

/**
 * This function checks on the local network weather
 * the firebase service is running or not
 * 
 * @returns Promise<boolean>
 */
const checkForLocalFirebase = async (): Promise<boolean> => {
    try {
        const res = await axios.get(`http://${firebaseHost}:${firebasePort}`)
        if (res.status == 200) {
            console.log("Using Local Firebase")
            return true
        } else {
            throw Error("Status Code not 200")
        }
    } catch (e) {
        console.log("Using Production Firebase")
        return false
    }
}

export {
    configureForLocalFirebase
}