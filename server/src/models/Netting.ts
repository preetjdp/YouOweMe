import { ObjectType, Field } from "type-graphql";
import { Owe } from "./Owe";
import { User } from "./User";

@ObjectType()
export class Netting {
    @Field(() => User)
    user: User

    @Field(() => [Owe])
    owes: Array<Owe>
}