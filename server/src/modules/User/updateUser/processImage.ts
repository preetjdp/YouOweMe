import { FileUpload } from "./fileUpload"
import Sharp from "sharp"
import { storageBucket } from "../../../db/firebase"
import { File } from "@google-cloud/storage"

export const processAndUploadImage = async (userId: string, file: FileUpload): Promise<string> => {
    try {
        const storageBucketFile: File = storageBucket.file(`user_data/${userId}/profile_picture.webp`)
        const rawFile = await file
        const readStream = rawFile.createReadStream()
        const pipline = Sharp().resize(400, 400).webp()
        const buffer = await readStream.pipe(pipline).toBuffer()

        await storageBucketFile.save(buffer)
        await storageBucketFile.makePublic()
        let randomFetchId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
        return `https://storage.googleapis.com/${storageBucketFile.storage.projectId}.appspot.com/${storageBucketFile.name}?id=${randomFetchId}`
    } catch (e) {
        throw e
    }
}