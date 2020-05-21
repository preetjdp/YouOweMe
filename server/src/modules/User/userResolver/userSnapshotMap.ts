import { DocumentSnapshot, Timestamp } from "@google-cloud/firestore";
import { User } from "../../../models/User";

type userSnapshotMapType = (snapshot: DocumentSnapshot) => User;

export const mapUserSnapshot: userSnapshotMapType = snapshot => {
    const userData = snapshot.data()
    if (!snapshot.exists) {
        throw Error("User Does Not Exist")
    }
    const created: Timestamp = userData!.created
    return {
        id: snapshot.id,
        name: userData!.name,
        image: userData!.image,
        mobileNo: userData!.mobile_no,
        fcmToken: userData!.fcm_token,
        created: created.toDate()
    }
}