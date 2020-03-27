import { User } from "./User"
import { ObjectType, Field, ID } from "type-graphql"
import { DocumentReference } from "@google-cloud/firestore"

@ObjectType()
export class Owe {
    @Field(() => ID)
    id: string

    documenmentRef: DocumentReference
    issuedToID: string
    issuedByID: string

    @Field()
    title: string

    @Field()
    amount: number

    @Field()
    issuedBy?: User

    @Field()
    issuedTo?: User

    @Field()
    created: Date
}