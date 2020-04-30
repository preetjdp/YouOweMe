import { Resolver, Mutation, Arg, Authorized } from "type-graphql"
import { Owe } from "../../models/Owe";
import { UpdateOweInputType } from "./updateOwe/updateOweInputType";
import { firestore } from "../../db/firebase";
import { OweResolver } from "../Owe/OweResolver"

@Resolver(Owe)
export class UpdateOweResolver {
    @Authorized()
    @Mutation(() => Owe, {
        description: "This Mutation gives one the ability to update values of a `Owe`.",
    })
    async updateOwe(@Arg("data") data: UpdateOweInputType) {
        //TODO This Query is very expensive!.
        const owes = await firestore.collectionGroup("owes").get()
        const filteredOwes = owes.docs.filter(doc => doc.id == data.id)
        if (filteredOwes.length == 0) {
            throw `No Owes with the Document ID ${data.id} found.`
        }
        const oweSnapshot = filteredOwes[0]
        const oweRef = oweSnapshot.ref
        const {id, ...updateData} = data 
        await oweRef.update({ ...updateData })
        const oweResponse = await new OweResolver().getOweFromRef(oweRef)
        return oweResponse
    }
}