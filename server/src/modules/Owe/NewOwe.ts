import { Resolver, Mutation, Authorized, Ctx, Args, Arg, FieldResolver, Root } from "type-graphql";
import { Owe } from "../../models/Owe.ts";
import { ApplicationContext } from "../../utils/appContext.ts";
import { firestore } from "../../db/firebase.ts";
import { NewOweInputType } from "./newOwe/newOweInputType.ts";
import { Timestamp } from "@google-cloud/firestore"
import { User } from "../../models/User.ts";

import { UserResolver } from "../User/UserResolver"
import { OweResolver } from "./OweResolver.ts";



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
        const oweResponse = await new OweResolver().getOweFromRef(oweRef)
        return oweResponse
    }
}