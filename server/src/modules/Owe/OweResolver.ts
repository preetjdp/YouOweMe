import { Resolver, FieldResolver, Root, } from "type-graphql";
import { Owe } from "../../models/Owe.ts";
import { User } from "../../models/User.ts";
import { UserResolver } from "../User/UserResolver.ts";
import { DocumentReference } from "@google-cloud/firestore"

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
    async issuedByFieldResolver(@Root() owe: Owe) {
        const oweRef = owe.documenmentRef
        const issuedByRef = oweRef.parent.parent
        const issedByUserId = issuedByRef!.id
        const issuedByUser = await new UserResolver().getUser(issedByUserId)
        return issuedByUser
    }

    @FieldResolver(() => User, {
        name: "issuedTo",
    })
    async issuedToFieldResolver(@Root() owe: Owe) {
        const userId: string = owe.issuedToID
        const user = await new UserResolver().getUser(userId)
        return user
    }
}