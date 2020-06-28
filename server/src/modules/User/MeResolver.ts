import { Resolver, Query, Authorized, Ctx, Subscription, Publisher, PubSub, Root, Info, FieldResolver } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { firestore } from "../../db/firebase";
import { User, MeUser } from "../../models/User";
import { Timestamp } from "@google-cloud/firestore";
import { UserResolver } from "./UserResolver";
import { userTopicGenerator } from "./userResolver/userTopic";
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader";
import { mapUserSnapshot } from "./userResolver/userSnapshotMap";
import { Netting } from "../../models/Netting";
import { Owe } from "../../models/Owe";


@Resolver(() => MeUser)
export class MeResolver {
    @Authorized()
    @Query(() => MeUser, {
        name: "Me"
    })
    async getMe(@Ctx() context: ApplicationContext, @RequestContainer() userDataLoader: UserDataLoader): Promise<MeUser> {
        const userId = context.req.headers.authorization!
        const userSnapshot = await userDataLoader.load(userId)
        if (!userSnapshot) {
            throw Error("User Snapshot from loader is Null in MeResolver")
        }
        const user = mapUserSnapshot(userSnapshot)
        return user
    }

    @Subscription(() => User, {
        name: "Me",
        topics: (context) =>
            userTopicGenerator(context.context.authorization)

    })
    async getMeSubscription(@Root() user: User) {
        return user
    }

    @FieldResolver(() => [Netting], {
        name: "nettings"
    })
    async nettingsFieldResolver(@Root() meUser: MeUser): Promise<Array<Netting>> {
        console.log(meUser)
        let userResolver = new UserResolver()
        let oweMe: Array<Owe> = await userResolver.oweMeFieldResolver(meUser)
        let iOwe: Array<Owe> = await userResolver.iOweFieldResolver(meUser)
        let wow = new Map<User, Array<Owe>>()
        oweMe.forEach((owe) => {
            wow.set(owe.issuedTo as User, [owe])
        })
        // let owes = [...oweMe, ...iOwe]
        console.log(wow)
        let result: Array<Netting> = Array.from(wow.keys()).map((user): Netting => {
            return {
                user,
                owes: wow.get(user)!
            }
        })
        return result
    }
}