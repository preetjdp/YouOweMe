import { InputType, Field, ID } from "type-graphql";
import { GraphQLUpload } from "apollo-server"
import { FileUpload } from "./fileUpload";

@InputType()
export class UpdateUserInputType {
    @Field(() => ID)
    id: string;

    @Field({
        nullable: true
    })
    name?: string

    @Field(() => GraphQLUpload!, {
        nullable: true
    })
    image?: FileUpload

    @Field({
        nullable: true
    })
    fcmToken?: string
}