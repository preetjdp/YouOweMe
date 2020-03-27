import { ObjectType, Field, ID } from "type-graphql";
import { Owe } from "./Owe.ts";

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

    @Field(() => [Owe])
    iOwe?: Array<Owe>

    @Field()
    created: Date
}