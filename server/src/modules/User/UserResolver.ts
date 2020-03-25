import { firestore } from "../../db/firebase"
import { Query, Resolver, FieldResolver, Root, Arg } from "type-graphql"
import { User } from "../../models/User"
import { DocumentData } from "@firebase/firestore-types"

@Resolver(User)
export class UserResolver {
    @Query(() => [User], {
        description: "Get all the users from the database."
    })
    async getUsers() {
        const usersRef = firestore.collection('users')
        const usersSnapshot = await usersRef.get()
        const users = usersSnapshot.docs.map((userSnapshot) => {
            const userData = userSnapshot.data()
            const user = {
                id: userSnapshot.id,
                name: userData.name,
                image: userData.image,
            }
            return user
        })
        return users
    }

    @Query(() => User, {
        nullable: true
    })
    async getUser(@Arg("id") id: string) {
        const userRef = firestore.collection('users').doc(id)
        const userSnapshot = await userRef.get()
        const userData = userSnapshot.data()
        if (!userSnapshot.exists) {
            return null
        }
        const user = {
            id: userSnapshot.id,
            name: userData!.name,
            image: userData!.image,
        }
        return user
    }
}
