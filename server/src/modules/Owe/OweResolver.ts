import { Resolver, FieldResolver, Root, Query, Arg, } from "type-graphql";
import { Owe } from "../../models/Owe";
import { User } from "../../models/User";
import { DocumentReference } from "@google-cloud/firestore"
import { RequestContainer, UserDataLoader } from "../User/userResolver/userLoader";
import { mapUserSnapshot } from "../User/userResolver/userSnapshotMap";
import { mapOweSnapshot } from "./oweResolver/oweSnapshotMap";
import { firestore } from "../../db/firebase";

@Resolver(Owe)
export class OweResolver {
    async getOweFromRef(oweRef: DocumentReference): Promise<Owe> {
        const oweSnapshot = await oweRef.get()
        const owe: Owe = await mapOweSnapshot(oweSnapshot);
        return owe
    }

    @Query(() => Owe, {
        name: "getOwe",
        description: "Query for one particular Owe"
    })
    async getOweFromId(@Arg("id") id: string): Promise<Owe> {
        const owes = await firestore.collectionGroup("owes").get()
        const filteredOwes = owes.docs.filter(doc => doc.id == id)
        if (filteredOwes.length == 0) {
            throw `No Owe with the Document ID ${id} found.`
        }
        const oweSnapshot = filteredOwes[0]
        const owe: Owe = await mapOweSnapshot(oweSnapshot)
        return owe
    }

    @FieldResolver(() => User, {
        name: "issuedBy",
        description: "This resolver fetches the `User` that has issued the `Owe`."
    })
    async issuedByFieldResolver(@Root() owe: Owe, @RequestContainer() userDataLoader: UserDataLoader) {
        const oweRef = owe.documenmentRef
        const issuedByRef = oweRef.parent.parent
        const issedByUserId = issuedByRef!.id
        const issuedByUserSnapshot = await userDataLoader.load(issedByUserId)
        if (!issuedByUserSnapshot) {
            throw Error("User Snapshot from loader is Null in oweResolver")
        }
        const issuedByUser = mapUserSnapshot(issuedByUserSnapshot)
        return issuedByUser
    }

    @FieldResolver(() => User, {
        name: "issuedTo",
        description: "This resolver fetches the `User` that the `Owe` is issued to."
    })
    async issuedToFieldResolver(@Root() owe: Owe, @RequestContainer() userDataLoader: UserDataLoader) {
        const userId: string = owe.issuedToID
        const issuedToUserSnapshot = await userDataLoader.load(userId)
        if (!issuedToUserSnapshot) {
            throw Error("User Snapshot from loader is Null in oweResolver")
        }
        const issuedToUser = mapUserSnapshot(issuedToUserSnapshot)
        return issuedToUser
    }
}