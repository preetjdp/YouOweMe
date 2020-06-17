import { FileUpload } from "./fileUpload"
import Sharp from "sharp"
import { storageBucket } from "../../../db/firebase"
import { File } from "@google-cloud/storage"
import { encode } from "blurhash"

export type ProcessAndUploadImageResponse = {
    url: string,
    blurhash: string
}

export const processAndUploadImage = async (userId: string, file: FileUpload): Promise<ProcessAndUploadImageResponse> => {
    try {
        const storageBucketFile: File = storageBucket.file(`user_data/${userId}/profile_picture.webp`)
        const rawFile = await file
        const readStream = rawFile.createReadStream()
        const parentPipline = Sharp()

        const blurHashPipeline = parentPipline.resize(32, 32).raw().ensureAlpha()
        const blurHashBuffer = await readStream.pipe(blurHashPipeline).toBuffer()
        let blurhash = blurHash(blurHashBuffer)

        const uploadPipeline = parentPipline.resize(400, 400).webp()
        const uploadBuffer = await readStream.pipe(uploadPipeline).toBuffer()
        await storageBucketFile.save(uploadBuffer)
        await storageBucketFile.makePublic()
        let randomFetchId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
        return {
            url: `https://storage.googleapis.com/${storageBucketFile.storage.projectId}.appspot.com/${storageBucketFile.name}?id=${randomFetchId}`,
            blurhash
        }
    } catch (e) {
        throw e
    }
}

const blurHash = (buffer: Buffer) => {
    const clampedArray = Uint8ClampedArray.from(buffer)
    return encode(clampedArray, 32, 32, 4, 4)
}