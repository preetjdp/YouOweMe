import { Resolver, Query, Authorized, Ctx } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext.ts";
import { firestore } from "../../db/firebase.ts";
import { User } from "../../models/User";
import { Timestamp } from "@google-cloud/firestore";

@Resolver()
export class MeResolver {
    @Authorized()
    @Query(() => User, {
        name: "Me"
    })
    async getMe(@Ctx() context: ApplicationContext): Promise<User> {
        console.log(context.req.headers.authorization + "wpwza")
        const userId = context.req.headers.authorization!
        const userRef = firestore.collection('users').doc(userId)
        const userSnapshot = await userRef.get()
        const userData = userSnapshot.data()
        const created: Timestamp = userData!.created
        const user: User = {
            id: userSnapshot.id,
            name: userData!.name,
            image: userData!.image,
            created: created.toDate()
        }
        return user
    }
}