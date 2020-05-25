import { Resolver, Query, Authorized, Ctx, Subscription, Publisher, PubSub, Root, Info } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { firestore } from "../../db/firebase";
import { User } from "../../models/User";
import { Timestamp } from "@google-cloud/firestore";
import { UserResolver } from "./UserResolver";
import { userTopicGenerator } from "./userResolver/userTopic";
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader";
import { mapUserSnapshot } from "./userResolver/userSnapshotMap";


@Resolver()
export class MeResolver {
    @Authorized()
    @Query(() => User, {
        name: "Me"
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
        topics: (context) =>
            userTopicGenerator(context.context.authorization)

    })
    async getMeSubscription(@Root() user: User) {
        return user
    }
}