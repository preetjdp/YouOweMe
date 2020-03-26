import { Resolver, Mutation, Authorized, Ctx, Args, Arg } from "type-graphql";
import { Owe } from "../../models/Owe.ts";
import { ApplicationContext } from "../../utils/appContext.ts";
import { firestore } from "../../db/firebase.ts";
import { NewOweInputType } from "./newOwe/newOweInputType.ts";
import { Timestamp } from "@google-cloud/firestore"

@Resolver(Owe)
export class NewOweResolver {
    @Authorized()
    @Mutation(() => Owe)
    async newOwe(
        @Arg("data")
        {
            title,
            amount,
            issuedToID
        }: NewOweInputType,
        @Ctx() context: ApplicationContext) {
        const userId = context.req.headers.authorization!
        const userRef = firestore.collection('users').doc(userId)
        const userSnapshot = await userRef.get()
        if (!userSnapshot.exists) {
            throw Error("User Not Present")
        }
        const issuedToRef = firestore.collection('users').doc(issuedToID)
        const owe = {
            title: title,
            amount: amount,
            issuedToRef: issuedToRef,
            created: Timestamp.fromMillis(Date.now())
        }
        const oweRef = await userRef.collection('owes').add(owe)
        const oweSnapshot = await oweRef.get()
        const oweData = oweSnapshot.data()
        const oweDate: Timestamp = oweData!.created
        const oweResponse = {
            id: oweSnapshot.id,
            title: oweData!.title,
            amount: oweData!.amount,
            created: oweDate.toDate(),
        }
        return oweResponse
    }
}