import { InputType, Field, Int } from "type-graphql";
import { OweState } from "../../../models/Owe";

@InputType({
    description: "The input type for the UpdateOwe Mutation"
})
export class UpdateOweInputType {
    @Field()
    id: string

    @Field(() => Int, {
        nullable: true
    })
    title?: string

    @Field({
        nullable: true,
        description: "Optional Value, used to upadte the amount of the `Owe`."
    })
    amount?: number

    @Field(() => OweState, {
        nullable: true,
        description: "Optional Value, used to upadte the state of the `Owe`."
    })
    state?: OweState
}