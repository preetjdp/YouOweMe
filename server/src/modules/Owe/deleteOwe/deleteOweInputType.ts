import { InputType, Field, ID } from "type-graphql";

@InputType({
    description: "The Input types used when deleting a `Owe`."
})
export class DeleteOweInputType {
    @Field(() => ID)
    id: string
}