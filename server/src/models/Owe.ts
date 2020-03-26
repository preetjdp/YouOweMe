import { User } from "./User"
import { ObjectType, Field, ID } from "type-graphql"

@ObjectType()
export class Owe {
    @Field(() => ID)
    id: string

    @Field()
    title: string

    @Field()
    amount: number

    @Field()
    issuedBy: User

    @Field()
    issuedTo: User

    @Field()
    created: Date
}