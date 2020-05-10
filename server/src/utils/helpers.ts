import { DocumentSnapshot } from "@google-cloud/firestore"
import { DynamicLinks } from "../utils/dynamicLinks"

export const getPermalinkFromOwe = async (snapshot: DocumentSnapshot): Promise<string> => {
    const oweData = snapshot.data()!
    if (oweData.permalink) {
        return oweData.permalink
    }
    const parameters = new DynamicLinks({
        link: "https://google.com",
        urlPrefix: "wow",
        androidParameters: {
            packageName: "wpw"
        }
    })
    
}