import { InputType, Field, Int } from "type-graphql";
import { Length, IsInt, IsPhoneNumber } from "class-validator"

@InputType({
    description: "The input type used when creating a new NewOwe."
})
export class NewOweInputType {
    @Field()
    @Length(1, 255)
    title: string

    @Field(() => Int)
    @IsInt()
    amount: number

    @Field({
        nullable: true,
        description: "The User ID of the User who owe's the money."
    })
    issuedToID: string

    @IsPhoneNumber("IN")
    @Field({
        nullable: true,
        description: "Optional Parameter, The mobile number has to be of type string and in such a format `+919594128425` "
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