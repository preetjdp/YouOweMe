import { Resolver, Query } from "type-graphql";
import { Owe } from "../../models/Owe.ts";
import { firestore } from "../../db/firebase.ts";
import { Timestamp, DocumentReference } from "@google-cloud/firestore"

@Resolver()
export class OwesResolver {

    @Query(() => [Owe])
    async getOwes() {
        const owesSnapshot = await firestore.collectionGroup('owes').get()
        const owes: Array<Owe> = owesSnapshot.docs.map((oweF) => {
            const oweFData = oweF.data()
            const oweFCreated: Timestamp = oweFData.created
            const issedToRef: DocumentReference = oweFData.issuedToRef
            const owe: Owe = {
                id: oweF.id,
                documenmentRef: oweF.ref,
                title: oweFData.title,
                amount: oweFData.amount,
                issuedByID: oweF.ref.parent.parent!.id,
                issuedToID: issedToRef.id,
                created: oweFCreated.toDate()
            }
            return owe
        })
        return owes
    }
}