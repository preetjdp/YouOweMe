import { InputType, Field, ID } from "type-graphql";

@InputType({
    description: "The input types for the Update User Mutation., only specfic fields can be specified."
})
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