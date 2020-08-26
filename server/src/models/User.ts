import { ObjectType, Field, ID } from "type-graphql";
import { Owe } from "./Owe";

@ObjectType()
export class User {
    @Field(() => ID, {
        description: "The unique ID of the user"
    })
    id: string;

    @Field()
    name: string;

    @Field({
        nullable: true
    })
    image: string;

    @Field()
    mobileNo: string;

    @Field(() => [Owe], {
        description: "This is the list of `Owe`'s that other poeple have to pay to this User."
    })
    oweMe?: Array<Owe>

    @Field({
        description: "The amount that other people owe to this person."
    })
    oweMeAmount?: number

    @Field(() => [Owe], {
        description: "This is the list of `Owe`'s that I owe to other people."
    })
    iOwe?: Array<Owe>

    @Field({
        description: "The amount that I owe to other people."
    })
    iOweAmount?: number

    @Field({
        description: "The Fcm Token to be used to send a notifiation to the `User` will be null if not present.",
        nullable: true
    })
    fcmToken: string

    @Field({
        description: "The Date at which the `User` was created."
    })
    created: Date
}