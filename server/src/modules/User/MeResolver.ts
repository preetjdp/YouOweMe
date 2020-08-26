import { Resolver, Query, Authorized, Ctx, Subscription, Root } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { User } from "../../models/User";
import { userTopicGenerator } from "./userResolver/userTopic";
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader";
import { mapUserSnapshot } from "./userResolver/userSnapshotMap";


@Resolver()
export class MeResolver {
    @Authorized()
    @Query(() => User, {
        name: "Me",
        description: "This is the `Me` Query, fetches the user using the ID from the Authorization Header."
    })
    async getMe(@Ctx() context: ApplicationContext, @RequestContainer() userDataLoader: UserDataLoader): Promise<User> {
        const userId = context.req.headers.authorization!
        const userSnapshot = await userDataLoader.load(userId)
        if (!userSnapshot) {
            throw Error("User Snapshot from loader is Null in MeResolver")
        }
        const user = mapUserSnapshot(userSnapshot)
        return user
    }

    @Subscription(() => User, {
        name: "Me",
        description: "The User Subscription Query.",
        topics: (context) =>
            userTopicGenerator(context.context.authorization)

    })
    async getMeSubscription(@Root() user: User) {
        return user
    }
}