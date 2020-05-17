import { ObjectType, Field, ID } from "type-graphql";
import { Owe } from "./Owe";
import { NotificationUnion } from "./Notification"

@ObjectType()
export class User {
    @Field(() => ID)
    id: string;

    @Field()
    name: string;

    @Field({
        nullable: true
    })
    image: string;

    @Field()
    mobileNo: string;

    @Field(() => [Owe])
    oweMe?: Array<Owe>

    @Field()
    oweMeAmount?: number

    @Field(() => [Owe])
    iOwe?: Array<Owe>

    @Field()
    iOweAmount?: number

    @Field({
        description: "The Fcm Token to be used to send a notifiation to the `User` will be null if not present.",
        nullable: true
    })
    fcmToken: string

    @Field()
    created: Date
}

@ObjectType()
export class Me extends User {
    @Field(() => [NotificationUnion])
    notifications?: [typeof NotificationUnion]
}