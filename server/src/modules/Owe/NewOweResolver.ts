import { Resolver, Mutation, Authorized, Ctx, Args, Arg, FieldResolver, Root } from "type-graphql";
import { Owe, OweState } from "../../models/Owe";
import { ApplicationContext } from "../../utils/appContext";
import { firestore, auth } from "../../db/firebase";
import { NewOweInputType } from "./newOwe/newOweInputType";
import { Timestamp, DocumentReference } from "@google-cloud/firestore"
import { OweResolver } from "./OweResolver";

@Resolver(Owe)
export class NewOweResolver {
    @Authorized()
    @Mutation(() => Owe, {
        description: "This mutation is used to create a new `Owe`."
    })
    async newOwe(@Arg("data") data: NewOweInputType,
        @Ctx() context: ApplicationContext) {
        const { title, amount, issuedToID, mobileNo, displayName } = data
        console.log(mobileNo)
        const userId = context.req.headers.authorization!
        const userRef = firestore.collection('users').doc(userId)
        const userSnapshot = await userRef.get()
        //Throw error when IssuedToID === context user ID
        if (issuedToID && issuedToID == userId) {
            throw new Error("Can't Lend yourself money")
        }
        if (!userSnapshot.exists) {
            throw Error("User Not Present")
        }
        let issuedToRef;
        if (issuedToID) {
            issuedToRef = firestore.collection('users').doc(issuedToID)
        } else if (mobileNo) {
            issuedToRef = await getUserRefFromMobileNo(mobileNo, displayName)
        } else {
            throw new Error("Either mobileNo or issuedToID is required")
        }
        const owe = {
            title: title,
            amount: amount,
            state: OweState.CREATED,
            issuedToRef: issuedToRef,
            created: Timestamp.fromMillis(Date.now())
        }
        const oweRef = await userRef.collection('owes').add(owe)
        const oweResponse = await new OweResolver().getOweFromRef(oweRef)
        return oweResponse
    }
}

/**
 * This function is used to get the user from their mobile number.
 * 
 * @param mobileNo The person's mobile number.
 * @param displayName The Person's Name -> Used to create the user if currently non existent.
 * 
 * The Logic for this function is as:
 *  1. Query for the user in Firestore.
 *  2. If user exists return his ref.
 *  3. If the User does not exist, create an Anonymuous User in Firebase Auth
 *  and return that ref. ==> As a side effect of this, this Anonymus User's Document should be 
 *  created with name and mobile_no
 */
const getUserRefFromMobileNo = async (mobileNo: string, displayName: string): Promise<DocumentReference> => {
    //TODO change this to a auth query in the future.
    const query = firestore.collection('users').where("mobile_no", "==", mobileNo);
    const users = await query.get()
    if (users.empty) {
        if (displayName) {
            const user = await auth.createUser({
                phoneNumber: mobileNo,
                displayName: displayName
            })
            const userRef = firestore.collection('users').doc(user.uid)
            return userRef
        }
        throw new Error(`Can't Find user with mobile_no ${mobileNo}`)
    }
    const userRef = users.docs[0].ref
    return userRef
}