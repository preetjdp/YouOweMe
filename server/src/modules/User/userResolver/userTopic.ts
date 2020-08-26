import { PubSubFire } from "../../../db/pubSubFire"
import { User } from "../../../models/User"
import { firestore } from "../../../db/firebase"
import { mapUserSnapshot } from "./userSnapshotMap"

/**
 * This is used to broadcast user document updates for subscription
 * queries.
 * 
 * @param id The User ID
 */
const userTopicGenerator = (id: string) => {
    try {
        PubSubFire.registerHandler(`user_subscription_${id}`.toString(), broadcast => {
            return firestore.collection('users').doc(id).onSnapshot((snapshot) => {
                const user: User = mapUserSnapshot(snapshot)
                broadcast(user)
            })
        })
    } catch (e) {
        //If the handler for the user already exists then don't cause error.
    }
    return `user_subscription_${id}`
}

export {
    userTopicGenerator
}