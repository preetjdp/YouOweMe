import { Resolver, Query } from "type-graphql";
import { Owe, OweState } from "../../models/Owe";
import { firestore } from "../../db/firebase";
import { Timestamp, DocumentReference } from "@google-cloud/firestore"
import { getPermalinkFromOwe } from "../../utils/helpers";

@Resolver()
export class OwesResolver {

    @Query(() => [Owe])
    async getOwes() {
        const owesSnapshot = await firestore.collectionGroup('owes').get()
        const owes: Array<Owe> = await Promise.all(owesSnapshot.docs.map(async (oweF) => {
            const oweFData = oweF.data()
            const oweFCreated: Timestamp = oweFData.created
            const issedToRef: DocumentReference = oweFData.issuedToRef
            const permalink = await getPermalinkFromOwe(oweF)
            const owe: Owe = {
                id: oweF.id,
                documenmentRef: oweF.ref,
                title: oweFData.title,
                amount: oweFData.amount,
                state: oweFData.state ?? OweState.CREATED,
                issuedByID: oweF.ref.parent.parent!.id,
                issuedToID: issedToRef.id,
                created: oweFCreated.toDate(),
                permalink: permalink
            }
            return owe
        }))
        return owes
    }
}