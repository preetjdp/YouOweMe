import { Resolver, Mutation, Authorized, Ctx, Args, Arg, FieldResolver, Root } from "type-graphql";
import { Owe } from "../../models/Owe.ts";
import { ApplicationContext } from "../../utils/appContext.ts";
import { firestore } from "../../db/firebase.ts";
import { NewOweInputType } from "./newOwe/newOweInputType.ts";
import { Timestamp } from "@google-cloud/firestore"
import { User } from "../../models/User.ts";

import { UserResolver } from "../User/UserResolver"

const userR = new UserResolver()


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
        const oweResponse: Owe = {
            id: oweSnapshot.id,
            documenmentRef: oweRef,
            title: oweData!.title,
            amount: oweData!.amount,
            created: oweDate.toDate(),
            issuedByID: userId,
            issuedToID: issuedToID
        }
        return oweResponse
    }

    @FieldResolver(() => User, {
        name: "issuedBy",
    })
    async issuedByResolver(@Root() owe: Owe) {
        const oweRef = owe.documenmentRef
        const issuedByRef = oweRef.parent.parent
        const issedByUserId = issuedByRef!.id
        const issuedByUser = await new UserResolver().getUser(issedByUserId)
        return issuedByUser
    }

    @FieldResolver(() => User, {
        name: "issuedTo",
    })
    async issuedToResolver(@Root() owe: Owe) {
        const userId : string = owe.issuedToID
        const user = await new UserResolver().getUser(userId)
        return user
    }
}