import { DocumentSnapshot } from "@google-cloud/firestore"
import { generateDynamicLink } from "../utils/dynamicLinks"

/**
 * Steps to be followed here.
 * @params DocumentSnapshot for the owe.
 * @returns The permalink for the `Owe`
 * 1. Check if Permalink exists in the document, if Yes, Return it.
 * 2. If No Generate the Url.
 * 3. Set that Url in Firestore and return the Url.
 */
export const getPermalinkFromOwe = async (snapshot: DocumentSnapshot): Promise<string> => {
    const oweData = snapshot.data()!
    const oweId = snapshot.id
    if (oweData.permalink) {
        return oweData.permalink
    }
    const link = generateDynamicLink({
        link: `https://youoweme.preetjdp.dev/owe/${oweId}`,
        domainUriPrefix: "youoweme.page.link",
        androidInfo: {
            androidPackageName: "dev.preetjdp.youoweme"
        },
        iosInfo: {
            iosBundleId: "dev.preetjdp.youoweme",
        },
        socialMetaTagInfo: {
            socialTitle: "New Owe",
        },
    }, {
        option: "SHORT"
    })

    return link

}