import { FileUpload } from "./fileUpload"
import Sharp from "sharp"
import { storageBucket } from "../../../db/firebase"
import { File } from "@google-cloud/storage"
import { encode } from "blurhash"
import { raw } from "express"

export const processAndUploadImage = async (userId: string, file: FileUpload): Promise<string> => {
    try {
        const storageBucketFile: File = storageBucket.file(`user_data/${userId}/profile_picture.webp`)
        const rawFile = await file
        const readStream = rawFile.createReadStream()
        const parentPipline = Sharp().resize(400, 400)

        const blurHashPipeline = parentPipline.raw().ensureAlpha()
        const blurHashBuffer = await readStream.pipe(blurHashPipeline).toBuffer()
        let blurhash = blurHash(blurHashBuffer)

        console.log(blurhash)


        const uploadPipeline = parentPipline.webp()
        const uploadBuffer = await readStream.pipe(uploadPipeline).toBuffer()
        await storageBucketFile.save(uploadBuffer)
        await storageBucketFile.makePublic()
        let randomFetchId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
        return `https://storage.googleapis.com/${storageBucketFile.storage.projectId}.appspot.com/${storageBucketFile.name}?id=${randomFetchId}`
    } catch (e) {
        throw e
    }
}

const blurHash = (buffer: Buffer) => {
    console.log(Uint8ClampedArray.from(buffer))
    const clampedArray = Uint8ClampedArray.from(buffer)
    return encode(clampedArray, 400, 400, 4, 4)
}