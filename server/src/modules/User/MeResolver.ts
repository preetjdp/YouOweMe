import { Resolver, Query, Authorized, Ctx, Subscription, Publisher, PubSub, Root, Info, FieldResolver } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { Me, User } from "../../models/User";
import { userTopicGenerator } from "./userResolver/userTopic";
import { NotificationUnion } from "../../models/Notification";
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader";
import { mapUserSnapshot } from "./userResolver/userSnapshotMap";


@Resolver(() => Me)
export class MeResolver {
    @Authorized()
    @Query(() => Me, {
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

    @FieldResolver(() => [NotificationUnion], { name: "notifications", })
    meNotificationsResolver() {
        return []
    }

    @Subscription(() => Me, {
        name: "Me",
        topics: (context) =>
            userTopicGenerator(context.context.authorization)

    })
    async getMeSubscription(@Root() user: Me) {
        return user
    }
}