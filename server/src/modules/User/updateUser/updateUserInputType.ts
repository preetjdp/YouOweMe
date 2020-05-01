import { InputType, Field, ID } from "type-graphql";
import { OweState, Owe } from "../../../models/Owe";

@InputType()
export class UpdateUserInputType {
    @Field(() => ID)
    id: string;

    @Field({
        nullable: true
    })
    name?: string

    @Field({
        nullable: true
    })
    fcmToken?: string
}