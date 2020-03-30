import { Resolver, Subscription, Arg, Root } from "type-graphql";
import { User } from "../../models/User";
import { userTopicGenerator } from "./userResolver/userTopic";

@Resolver(User)
export class UserSubscriptionResolver {
    @Subscription(() => User, {
        name: "User",
        topics: ({ args, info }) => userTopicGenerator(args.id)


    })
    getUser(@Arg("id") _id: string, @Root() user: User) {
        return user
    }
}