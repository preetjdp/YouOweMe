import { PubSubFire } from "../../../db/pubSubFire"
import { Timestamp } from "@google-cloud/firestore"
import { User } from "../../../models/User"
import { firestore } from "../../../db/firebase"

const userTopicGenerator = (id: string) => {
    try {
        PubSubFire.registerHandler(`user_subscription_${id}`.toString(), broadcast => {
            return firestore.collection('users').doc(id).onSnapshot((snapshot) => {
                const userData = snapshot.data()
                const created: Timestamp = userData!.created
                const user: User = {
                    id: snapshot.id,
                    name: userData!.name,
                    image: userData!.image,
                    created: created.toDate()
                }
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