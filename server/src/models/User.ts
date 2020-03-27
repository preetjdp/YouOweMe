import { ObjectType, Field, ID } from "type-graphql";
import { Owe } from "./Owe";

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

    @Field(() => [Owe])
    oweMe?: Array<Owe>

    @Field()
    oweMeAmount?: number
    
    @Field(() => [Owe])
    iOwe?: Array<Owe>

    @Field()
    iOweAmount?: number

    @Field()
    created: Date
}