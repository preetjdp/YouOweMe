import { Resolver, FieldResolver, Root, } from "type-graphql";
import { Owe, OweState } from "../../models/Owe";
import { User } from "../../models/User";
import { UserResolver } from "../User/UserResolver";
import { DocumentReference } from "@google-cloud/firestore"
import { RequestContainer, UserDataLoader } from "../User/userResolver/userLoader";

@Resolver(Owe)
export class OweResolver {
    async getOweFromRef(oweRef: DocumentReference): Promise<Owe> {
        const oweSnapshot = await oweRef.get()
        if (!oweSnapshot.exists) {
            throw Error("Owe Does Not Exist")
        }
        const oweData = oweSnapshot.data()
        const oweDate = oweData!.created
        const issuedToRef: DocumentReference = oweData!.issuedToRef;
        const owe: Owe = {
            id: oweSnapshot.id,
            documenmentRef: oweRef,
            title: oweData!.title,
            amount: oweData!.amount,
            state: oweData?.state ?? OweState.CREATED,
            created: oweDate.toDate(),
            issuedByID: oweSnapshot.ref.parent!.parent!.id,
            issuedToID: issuedToRef.id
        }
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
        const issuedByUser = await new UserResolver().getUser(issedByUserId, userDataLoader)
        return issuedByUser
    }

    @FieldResolver(() => User, {
        name: "issuedTo",
    })
    async issuedToFieldResolver(@Root() owe: Owe, @RequestContainer() userDataLoader: UserDataLoader) {
        const userId: string = owe.issuedToID
        const user = await new UserResolver().getUser(userId, userDataLoader)
        return user
    }
}