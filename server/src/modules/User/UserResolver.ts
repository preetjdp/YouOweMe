import { firestore } from "../../db/firebase"
import { Query, Resolver, FieldResolver, Root, Arg, Int } from "type-graphql"
import { User } from "../../models/User"
import { DocumentSnapshot } from "@google-cloud/firestore"
import { Owe, OweState } from "../../models/Owe"
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader"
import { mapUserSnapshot } from "./userResolver/userSnapshotMap"
import { mapOweSnapshot } from "../Owe/oweResolver/oweSnapshotMap"

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
        nullable: true,
        description: "Query for one particular user"
    })
    async getUser(@Arg("id") id: string, @RequestContainer() userDataLoader: UserDataLoader): Promise<User> {
        const userSnapshot = await userDataLoader.load(id) as DocumentSnapshot
        const user: User = mapUserSnapshot(userSnapshot)
        return user
    }

    @FieldResolver(() => [Owe], {
        name: "oweMe",
        description: "The Field resolver which fetches the `Owe`'s that other people owe this person."
    })
    async oweMeFieldResolver(@Root() user: User): Promise<Array<Owe>> {
        const userRef = firestore.collection('users').doc(user.id)
        const oweMeRef = userRef.collection('owes')
        const oweMeQuerySnaphot = await oweMeRef.get()
        if (oweMeQuerySnaphot.docs.length == 0) {
            return []
        }
        const owes: Array<Owe> = await Promise.all(oweMeQuerySnaphot.docs.map(async (oweF) => {
            const owe: Owe = await mapOweSnapshot(oweF)
            return owe
        }))
        return owes
    }

    @FieldResolver(() => [Owe], {
        name: "iOwe",
        description: "The Field resolver which fetches the `Owe`'s that this person owes to Other People."
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
        const owes: Array<Owe> = await Promise.all(iOweQuerySnaphot.docs.map(async (oweF) => {
            const owe: Owe = await mapOweSnapshot(oweF);
            return owe
        }))
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
