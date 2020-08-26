import { Resolver, Query } from "type-graphql";
import { Owe, OweState } from "../../models/Owe";
import { firestore } from "../../db/firebase";
import { mapOweSnapshot } from "./oweResolver/oweSnapshotMap";

@Resolver()
export class OwesResolver {
    @Query(() => [Owe], {
        description: "Fetch all owes in the system"
    })
    async getOwes() {
        const owesSnapshot = await firestore.collectionGroup('owes').get()
        const owes: Array<Owe> = await Promise.all(owesSnapshot.docs.map(async (oweF) => {
            const owe: Owe = await mapOweSnapshot(oweF);
            return owe
        }))
        return owes
    }
}