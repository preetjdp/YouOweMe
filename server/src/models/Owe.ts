import { User } from "./User"
import { ObjectType, Field, ID, registerEnumType, Int, InterfaceType } from "type-graphql"
import { DocumentReference } from "@google-cloud/firestore"

@InterfaceType()
abstract class IOwe {
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

@ObjectType({
    implements: IOwe
})
class Owe implements IOwe {
    id: string
    documenmentRef: DocumentReference
    issuedToID: string
    issuedByID: string
    title: string
    amount: number
    state: OweState
    issuedBy?: User
    issuedTo?: User
    created: Date
    permalink: string
}

@ObjectType({
    implements: IOwe
})
class NettingOwe extends IOwe {
    @Field()
    oweType: NettingOweType
}

enum NettingOweType {
    OWEME = "OWEME",
    IOWE = "IOWE"
}

registerEnumType(NettingOweType, {
    name: "NettingOweType",
    description: "Defines the type of a `Owe` in a Netting."
})

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
    IOwe,
    Owe,
    OweState,
    NettingOwe,
    NettingOweType
}