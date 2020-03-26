import { InputType, Field } from "type-graphql";
import {Length, IsInt} from "class-validator"

@InputType()
export class NewOweInputType {
    @Field()
    @Length(1, 255)
    title: string

    @Field()
    @IsInt()
    amount: number

    @Field()
    issuedToID: string
}