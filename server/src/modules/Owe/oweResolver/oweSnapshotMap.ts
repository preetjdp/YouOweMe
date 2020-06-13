import { DocumentSnapshot, DocumentReference } from "@google-cloud/firestore";
import { Owe, OweState } from "../../../models/Owe";
import { getPermalinkFromOwe } from "../../../utils/helpers";

type oweSnapshotMapType = (snapshot: DocumentSnapshot) => Promise<Owe>;

export const mapOweSnapshot: oweSnapshotMapType = async snapshot => {
    if (!snapshot.exists) {
        throw Error("Owe Does Not Exist")
    }
    const oweData = snapshot.data()
    const oweDate = oweData!.created
    const issuedToRef: DocumentReference = oweData!.issuedToRef
    const permalink = await getPermalinkFromOwe(snapshot)
    const owe: Owe = {
        id: snapshot.id,
        documenmentRef: snapshot.ref,
        title: oweData!.title,
        amount: oweData!.amount,
        state: oweData?.state ?? OweState.CREATED,
        created: oweDate.toDate(),
        issuedByID: snapshot.ref.parent!.parent!.id,
        issuedToID: issuedToRef.id,
        permalink: permalink
    }
    return owe
}