import { User } from "./User"
import { ObjectType, Field, ID, registerEnumType, Int } from "type-graphql"
import { DocumentReference } from "@google-cloud/firestore"

@ObjectType()
class Owe {
    @Field(() => ID)
    id: string

    documenmentRef: DocumentReference
    issuedToID: string
    issuedByID: string

    @Field()
    title: string

    @Field(() => Int)
    amount: number

    @Field(() => OweState)
    state: OweState

    @Field()
    issuedBy?: User

    @Field()
    issuedTo?: User

    @Field()
    created: Date

    @Field()
    permalink: string
}

enum OweState {
    CREATED = "CREATED",
    DECLINED = "DECLINED",
    ACKNOWLEDGED = "ACKNOWLEDGED",
    PAID = "PAID",
    // DELAYED = "DELAYED",
}

registerEnumType(OweState, {
    name: "OweState",
    description: "Defines the states that a `Owe` can be In. The default is Opened"
})

export {
    Owe,
    OweState
}