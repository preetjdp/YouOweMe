import { InputType, Field } from "type-graphql";
import { Length, IsInt, IsPhoneNumber } from "class-validator"

@InputType()
export class NewOweInputType {
    @Field()
    @Length(1, 255)
    title: string

    @Field()
    @IsInt()
    amount: number

    @Field({ nullable: true })
    issuedToID: string

    @IsPhoneNumber("IN")
    @Field({
        nullable: true,
        description: "The mobile number has to be of type string and in such a format `+919594128425` "
    }
    )
    mobileNo: string

    @Field({
        nullable: true,
        description: "This Field has to be provided with Number."
    }
    )
    displayName: string
}