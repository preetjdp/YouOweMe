import { FileUpload } from "./fileUpload"
import Sharp from "sharp"

export const processImage = async (file: FileUpload): Promise<void> => {
    try {
        const rawFile = await file
        const readStream = rawFile.createReadStream()
        const pipline = Sharp().resize(400, 400)
        await readStream.pipe(pipline).webp()
            .toFile(__dirname + `image_size_150x150.webp`)
    } catch (e) {
        throw e
    }
}