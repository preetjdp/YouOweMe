import axios from "axios"
import { firestore } from "../db/firebase"

const configureForLocalFirebase = async () => {
    const useLocalFirebase = await checkForLocalFirebase()
    if (useLocalFirebase) {
        firestore.settings({
            host: 'localhost',
            ssl: false,
            port: 8080
        })
    }
}

const checkForLocalFirebase = async (): Promise<boolean> => {
    try {
        const res = await axios.get("http://localhost:8080")
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