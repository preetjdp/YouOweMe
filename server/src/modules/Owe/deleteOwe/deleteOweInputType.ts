import { InputType, Field, ID } from "type-graphql";

@InputType()
export class DeleteOweInputType {
    @Field(() => ID)
    id: string
}