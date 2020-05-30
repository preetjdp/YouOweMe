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
    const oweTitle: string = oweData.title
    const oweId = snapshot.id
    if (oweData.permalink) {
        return oweData.permalink
    }
    const link = `https://youoweme.preetjdp.dev/owe/${oweId}`
    const dynamicLink = await generateDynamicLink({
        link: link,
        domainUriPrefix: "youoweme.page.link",
        androidInfo: {
            androidPackageName: "dev.preetjdp.youoweme",
            androidFallbackLink: link
        },
        iosInfo: {
            iosBundleId: "dev.preetjdp.youoweme",
            iosFallbackLink: link
        },
        socialMetaTagInfo: {
            socialTitle: "Owe Details",
            socialDescription: oweTitle,
            socialImageLink: "https://firebasestorage.googleapis.com/v0/b/youoweme-6c622.appspot.com/o/statics%2Flogo_small.png?alt=media&token=f42fa2b3-77dd-4afe-9627-7df493e036e9"
        },
    }, {
        option: "SHORT"
    })

    snapshot.ref.update({ "permalink": dynamicLink })

    return dynamicLink
}