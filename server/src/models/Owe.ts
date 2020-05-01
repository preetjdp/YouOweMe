import { User } from "./User"
import { ObjectType, Field, ID, registerEnumType } from "type-graphql"
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

    @Field()
    amount: number

    @Field(() => OweState)
    state: OweState

    @Field()
    issuedBy?: User

    @Field()
    issuedTo?: User

    @Field()
    created: Date
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