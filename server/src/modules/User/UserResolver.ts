import { firestore } from "../../db/firebase"
import { Query, Resolver, FieldResolver, Root, Arg, Authorized, Int } from "type-graphql"
import { User } from "../../models/User"
import { DocumentReference, Timestamp, DocumentSnapshot } from "@google-cloud/firestore"
import { Owe, OweState } from "../../models/Owe"
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader"
import { mapUserSnapshot } from "./userResolver/userSnapshotMap"

@Resolver(User)
export class UserResolver {
    @Query(() => [User], {
        description: "Get all the users from the database."
    })
    async getUsers() {
        const usersRef = firestore.collection('users')
        const usersSnapshot = await usersRef.get()
        const users = usersSnapshot.docs.map((userSnapshot) => {
            const user: User = mapUserSnapshot(userSnapshot)
            return user
        })
        return users
    }

    @Query(() => User, {
        nullable: true
    })
    async getUser(@Arg("id") id: string, @RequestContainer() userDataLoader: UserDataLoader): Promise<User> {
        const userSnapshot = await userDataLoader.load(id) as DocumentSnapshot
        const user: User = mapUserSnapshot(userSnapshot)
        return user
    }

    @FieldResolver(() => [Owe], {
        name: "oweMe",
    })
    async oweMeFieldResolver(@Root() user: User): Promise<Array<Owe>> {
        const userRef = firestore.collection('users').doc(user.id)
        const oweMeRef = userRef.collection('owes')
        const oweMeQuerySnaphot = await oweMeRef.get()
        if (oweMeQuerySnaphot.docs.length == 0) {
            return []
        }
        const owes: Array<Owe> = oweMeQuerySnaphot.docs.map((oweF) => {
            const oweFData = oweF.data()
            const oweFCreated: Timestamp = oweFData.created
            const issedToRef: DocumentReference = oweFData.issuedToRef
            const owe: Owe = {
                id: oweF.id,
                documenmentRef: oweF.ref,
                title: oweFData.title,
                amount: oweFData.amount,
                state: oweFData.state ?? OweState.CREATED,
                issuedByID: oweF.ref.parent.parent!.id,
                issuedToID: issedToRef.id,
                created: oweFCreated.toDate()
            }
            return owe
        })
        return owes
    }

    @FieldResolver(() => [Owe], {
        name: "iOwe",
    })
    async iOweFieldResolver(@Root() user: User): Promise<Array<Owe>> {
        const userRef = firestore.collection('users').doc(user.id)
        const iOweQuery = firestore
            .collectionGroup('owes')
            .where("issuedToRef", "==", userRef)

        const iOweQuerySnaphot = await iOweQuery.get()
        if (iOweQuerySnaphot.docs.length == 0) {
            return []
        }
        const owes: Array<Owe> = iOweQuerySnaphot.docs.map((oweF) => {
            const oweFData = oweF.data()
            const oweFCreated: Timestamp = oweFData.created
            const issedToRef: DocumentReference = oweFData.issuedToRef
            const owe: Owe = {
                id: oweF.id,
                documenmentRef: oweF.ref,
                title: oweFData.title,
                amount: oweFData.amount,
                state: oweFData.state ?? OweState.CREATED,
                issuedByID: oweF.ref.parent.parent!.id,
                issuedToID: issedToRef.id,
                created: oweFCreated.toDate()
            }
            return owe
        })
        return owes
    }

    @FieldResolver(() => Int, {
        name: "oweMeAmount"
    }
    )
    async oweMeAmountFieldResolver(@Root() user: User) {
        const owes: Array<Owe> = await this.oweMeFieldResolver(user)
        let oweMeAmount: number = 0
        for (const owe of owes) {
            if (owe.state == OweState.ACKNOWLEDGED || owe.state == OweState.CREATED)
                oweMeAmount += owe.amount
        }
        return oweMeAmount
    }

    @FieldResolver(() => Int, {
        name: "iOweAmount"
    }
    )
    async iOweAmountFieldResolver(@Root() user: User) {
        const owes: Array<Owe> = await this.iOweFieldResolver(user)
        let iOweAmount: number = 0
        for (const owe of owes) {
            if (owe.state == OweState.ACKNOWLEDGED || owe.state == OweState.CREATED)
                iOweAmount += owe.amount
        }
        return iOweAmount
    }
}
