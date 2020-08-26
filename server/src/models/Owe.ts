import { User } from "./User"
import { ObjectType, Field, ID, registerEnumType, Int } from "type-graphql"
import { DocumentReference } from "@google-cloud/firestore"

@ObjectType({
    description: "The `Owe` Model, used to when a person owes someone some money"
})
class Owe {
    @Field(() => ID, {
        description: "This is the unique ID of the `Owe`, no two owes will have the same `ID`."
    })
    id: string

    documenmentRef: DocumentReference
    issuedToID: string
    issuedByID: string

    @Field({
        description: "This explains the `Owe` the best."
    })
    title: string

    @Field(() => Int, {
        description: "The amount exchanged as part of the `Owe`"
    })
    amount: number

    @Field(() => OweState, {
        description: "The Current state the `Owe` is in."
    })
    state: OweState

    @Field({
        description: "The user that gave the money."
    })
    issuedBy?: User

    @Field({
        description: "The user that received the money."
    })
    issuedTo?: User

    @Field({
        description: "The Date at which the `Owe` was created."
    })
    created: Date

    @Field({
        description: "The permalink which can be used to share the `Owe`."
    })
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