
import { firestore } from "../../../db/firebase"
import { Timestamp } from "@google-cloud/firestore";
import { User } from "../../../models/User";
import { PubSubFire } from "../../../db/pubSubFire";


const meTopicHandler = (id: string) => {
    PubSubFire.registerHandler("user" + id, broadcast => {
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
    return "user" + id
}

export {
    meTopicHandler
}