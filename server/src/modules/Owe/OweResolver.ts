import { Resolver, FieldResolver, Root, } from "type-graphql";
import { Owe, OweState } from "../../models/Owe";
import { User } from "../../models/User";
import { UserResolver } from "../User/UserResolver";
import { DocumentReference } from "@google-cloud/firestore"
import { getPermalinkFromOwe } from "../../utils/helpers"
import { RequestContainer, UserDataLoader } from "../User/userResolver/userLoader";
import { mapUserSnapshot } from "../User/userResolver/userSnapshotMap";
import { mapOweSnapshot } from "./oweResolver/oweSnapshotMap";

@Resolver(Owe)
export class OweResolver {
    async getOweFromRef(oweRef: DocumentReference): Promise<Owe> {
        const oweSnapshot = await oweRef.get()
        const owe: Owe = await mapOweSnapshot(oweSnapshot);
        return owe
    }

    async getOwesFromUserRef() { }
    @FieldResolver(() => User, {
        name: "issuedBy",
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