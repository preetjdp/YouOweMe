import { ObjectType, Field, ID, InterfaceType } from "type-graphql";
import { Owe } from "./Owe";
import { Netting } from "./Netting";

@InterfaceType()
class IUser {
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

    @Field({
        description: "The Fcm Token to be used to send a notifiation to the `User` will be null if not present.",
        nullable: true
    })
    fcmToken: string

    @Field()
    created: Date
}

@ObjectType({
    implements: IUser
})
export class User implements IUser {
    id: string
    name: string
    image: string
    mobileNo: string
    fcmToken: string
    created: Date
}

//TODO Maybe Consider Changing this name.
@ObjectType({
    implements: IUser
})
export class MeUser extends IUser {
    @Field(() => [Owe])
    oweMe: Array<Owe>

    @Field()
    oweMeAmount?: number

    @Field(() => [Owe])
    iOwe: Array<Owe>

    @Field()
    iOweAmount?: number

    @Field(() => [Netting])
    nettings?: Array<Netting>
}