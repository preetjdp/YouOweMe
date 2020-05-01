import { Resolver, Arg, Mutation, Authorized } from "type-graphql";
import { User } from "../../models/User";
import { UpdateUserInputType } from "./updateUser/updateUserInputType.ts";
import { firestore } from "../../db/firebase";
import { UserResolver } from "./UserResolver"

@Resolver(User)
export class UpdateUserResolver {
    @Authorized()
    @Mutation(() => User, {
        description: "This Mutation gives one the ability to update values of a `User`. Currently only supports updating the name and the fcm_token",
    })
    async updateUser(@Arg("data") data: UpdateUserInputType) {
        const userId = data.id
        const userRef = firestore.collection('users').doc(userId)
        try {
            // This is a anti-pattern
            // Would not recommend for larger systems
            // Is done bacause fieldNames are different in server and database
            let { id, fcmToken, ...updateData } = data
            console.log(updateData)
            await userRef.update({
                ...(fcmToken && { fcm_token: fcmToken }),
                ...updateData
            })
            let user = await new UserResolver().getUser(userId)
            return user
        } catch (e) {
            throw e
        }
    }
}