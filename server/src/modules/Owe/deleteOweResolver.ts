import { Resolver, Mutation, Arg, Ctx } from "type-graphql";
import { Owe } from "../../models/Owe";
import { DeleteOweInputType } from "./deleteOwe/deleteOweInputType";
import { ApplicationContext } from "../../utils/appContext";
import { firestore } from "../../db/firebase";
import { Timestamp } from "@google-cloud/firestore";

@Resolver(Owe)
export class DeleteOweResolver {
    @Mutation(() => Date, {})
    async deleteOwe(@Arg("data") data: DeleteOweInputType, @Ctx() context: ApplicationContext) {
        const userId = context.req.headers.authorization!;
        const userRef = firestore.collection('users').doc(userId)
        const oweRef = userRef.collection('owes').doc(data.id)

        const oweSnapshot = await oweRef.get()
        if (!oweSnapshot.exists) {
            throw `No Owe with the Document ID ${data.id} found for user ${userId}`
        }
        await oweRef.delete();

        // Used Timestamp because the Date api was too dumb to 
        // deal with.
        // new Date().toISOString()
        return Timestamp.now().toDate()
    }
}