import { ObjectType, Field } from "type-graphql";
import { Owe, NettingOwe } from "./Owe";
import { User } from "./User";

@ObjectType()
export class Netting {
    @Field(() => User)
    user: User

    @Field(() => [NettingOwe])
    owes: Array<NettingOwe>
}