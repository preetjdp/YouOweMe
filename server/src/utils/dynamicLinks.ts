import axios from "axios"

/**
 * @params link The link your app will open.
 * @params domainUriPrefix The URL Prefix for the app.
 * @params androidParameters The Android Parameters for the URL.
 * @params iosParameters The IOS Parameters for the URL.
 * @params navigationInfoParameters The Navigation Parameters for the URL.
 * @params suffix Should the end url be short or long
 */
type DynamicLinkParameters = {
    link: string
    domainUriPrefix: string
    androidInfo: AndroidParameters
    iosInfo: IosParameters
    socialMetaTagInfo: SocialMetaTagParameters
    navigationInfo?: NavigationInfoParameters
}

type AndroidParameters = {
    /** The package name of the Android app to use to open the link. */
    androidPackageName: string
    /** The link to open when the app isn't installed.  */
    androidFallbackLink?: string
}

type IosParameters = {
    /** The bundle ID of the iOS app to use to open the link. */
    iosBundleId: string,
    /** The link to open when the app isn't installed. */
    iosFallbackLink?: string
}

type NavigationInfoParameters = {
    /** If set to '1', skip the app preview page when the Dynamic Link is opened, and instead redirect to the app or store. */
    enableForcedRedirect: boolean
}

type SocialMetaTagParameters = {
    /** The title to use when the Dynamic Link is shared in a social post. */
    socialTitle: string
    /** The description to use when the Dynamic Link is shared in a social post. */
    socialDescription?: string
    /** The URL to an image related to this link. The image should be at least 300x200 px, and less than 300 KB.*/
    socialImageLink?: string
}

type SuffixParameter = {
    option: "SHORT" | "UNGUESSABLE"
}

/**
 * 
 * @param parameters The Parameters of type `DynamicLinkParameters`.
 * These are the values that are important
 * 
 * @param suffix To generate a Short url or a Long one
 * 
 * @returns Promise<String>
 */
export const generateDynamicLink = async (parameters: DynamicLinkParameters, suffix: SuffixParameter): Promise<string> => {
    const api_key = "AIzaSyC9mDgysM-vQlguS3X52Kx42sOmrDtKVAY"
    const requestBody = {
        dynamicLinkInfo: parameters,
        suffix
    }
    const response = await axios.post(`https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=${api_key}`, requestBody)
    return response.data.shortLink
}