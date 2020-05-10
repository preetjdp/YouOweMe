import axios from "axios"
import buildUrl from "build-url"

export class DynamicLinks {
    dynamicLinkParameters: DynamicLinkParameters
    constructor(parameters: DynamicLinkParameters) {
        this.dynamicLinkParameters = parameters
    }

    buildShortLink() {
        axios.post("https://Google.com",{
            data: {}
        })
    }

    // async buildShortLink(): Promise<string> {
    // }
}

interface DynamicLinkParameters {
    androidParameters?: AndroidParameters

    urlPrefix: string

    iosParameters?: IosParameters

    link: string

    navigationInfoParameters?: NavigationInfoParameters

}

interface AndroidParameters {
    packageName: string
    fallbackUrl?: string
    minimumVersion?: number
}

interface IosParameters {
    appStoreId: string

    bundleId: string

    customScheme?: string

    fallbackUrl?: string

    ipadBundleId?: string

    ipadFallbackUrl?: string

    minimumVersion?: string
}

interface NavigationInfoParameters {
    forcedRedirectEnabled: boolean
}