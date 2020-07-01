import { Resolver, Query, Authorized, Ctx, Subscription, Publisher, PubSub, Root, Info, FieldResolver, Int, Arg } from "type-graphql";
import { ApplicationContext } from "../../utils/appContext";
import { firestore } from "../../db/firebase";
import { User, MeUser } from "../../models/User";
import { Timestamp } from "@google-cloud/firestore";
import { UserResolver } from "./UserResolver";
import { userTopicGenerator } from "./userResolver/userTopic";
import { RequestContainer, UserDataLoader } from "./userResolver/userLoader";
import { mapUserSnapshot } from "./userResolver/userSnapshotMap";
import { Netting } from "../../models/Netting";
import { Owe, OweState, NettingOwe, NettingOweType } from "../../models/Owe";
import { mapOweSnapshot } from "../Owe/oweResolver/oweSnapshotMap";


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
        let iOwe = await this.iOweResolver(userId)
        let oweMe = await this.oweMeResolver(userId)
        let meUser: MeUser = {
            ...user,
            iOwe,
            oweMe
        }
        return meUser
    }

    @FieldResolver(() => Int, {
        name: "oweMeAmount"
    }
    )
    async oweMeAmountFieldResolver(@Root() user: MeUser,
        @Arg("oweState", () => [OweState],
            {
                defaultValue: [OweState.ACKNOWLEDGED, OweState.CREATED],
            }) oweState: [OweState]) {
        const owes: Array<Owe> = user.oweMe
        let oweMeAmount = owes
            .filter((owe) => oweState.includes(owe.state))
            .map((owe) => owe.amount)
            .reduce((prev, curr) => prev + curr)
        return oweMeAmount
    }

    @FieldResolver(() => Int, {
        name: "iOweAmount"
    }
    )
    async iOweAmountFieldResolver(@Root() user: MeUser,
        @Arg("oweState", () => [OweState],
            {
                defaultValue: [OweState.ACKNOWLEDGED, OweState.CREATED],
            }) oweState: [OweState]
    ) {
        const owes: Array<Owe> = user.iOwe
        let iOweAmount = owes
            .filter((owe) => oweState.includes(owe.state))
            .map((owe) => owe.amount)
            .reduce((prev, curr) => prev + curr)
        return iOweAmount
    }

    @FieldResolver(() => [Netting], {
        name: "nettings"
    })
    async nettingsFieldResolver(@Root() user: MeUser, @RequestContainer() userDataLoader: UserDataLoader,
        @Arg("oweState", () => [OweState],
            {
                defaultValue: [OweState.ACKNOWLEDGED, OweState.CREATED],
            }) oweState: [OweState]
    ): Promise<Array<Netting>> {
        let oweMe: Array<Owe> = user.oweMe.filter((owe) => oweState.includes(owe.state))
        let iOwe: Array<Owe> = user.iOwe.filter((owe) => oweState.includes(owe.state))
        let nettingsMap = new Map<string, Array<NettingOwe>>()
        oweMe.forEach((owe) => {
            console.log(owe.issuedToID)
            let existingList = nettingsMap.get(owe.issuedToID) ?? []
            nettingsMap.set(owe.issuedToID, [...existingList, { ...owe, oweType: NettingOweType.OWEME }])
        })

        iOwe.forEach((owe) => {
            console.log(owe.issuedToID)
            let existingList = nettingsMap.get(owe.issuedByID) ?? []
            nettingsMap.set(owe.issuedByID, [...existingList, { ...owe, oweType: NettingOweType.IOWE }])
        })
        // let owes = [...oweMe, ...iOwe]
        // console.log(wow)
        let result = await Promise.all(Array.from(nettingsMap.keys()).map(async (userId): Promise<Netting> => {
            let userSnapshot = await userDataLoader.load(userId);
            let user = mapUserSnapshot(userSnapshot!);
            return {
                user,
                owes: nettingsMap.get(userId)!
            }
        }))
        return result
    }

    async oweMeResolver(userId: string): Promise<Array<Owe>> {
        const userRef = firestore.collection('users').doc(userId)
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

    async iOweResolver(userId: string): Promise<Array<Owe>> {
        const userRef = firestore.collection('users').doc(userId)
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
}