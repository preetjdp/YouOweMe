import { Resolver, Query, Authorized, Ctx, Subscription, Publisher, PubSub, Root, FieldResolver } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { firestore } from "../../db/firebase";
import { Me } from "../../models/User";
import { Timestamp } from "@google-cloud/firestore";
import { UserResolver } from "./UserResolver";
import { userTopicGenerator } from "./userResolver/userTopic";
import { NotificationUnion } from "../../models/Notification";


@Resolver(() => Me)
export class MeResolver {
    @Authorized()
    @Query(() => Me, {
        name: "Me"
    })
    async getMe(@Ctx() context: ApplicationContext): Promise<Me> {
        console.log(context.req.headers.authorization + "wpwza")
        const userId = context.req.headers.authorization!
        const user = await new UserResolver().getUser(userId)
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