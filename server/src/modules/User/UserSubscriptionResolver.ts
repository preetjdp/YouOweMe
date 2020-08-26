import { Resolver, Subscription, Arg, Root } from "type-graphql";
import { User } from "../../models/User";
import { userTopicGenerator } from "./userResolver/userTopic";

@Resolver(User)
export class UserSubscriptionResolver {
    @Subscription(() => User, {
        name: "User",
        topics: ({ args }) => userTopicGenerator(args.id),
        description: "This Subscription is used to get realtime updates for a user."
    })
    getUser(@Arg("id") _id: string, @Root() user: User) {
        return user
    }
}