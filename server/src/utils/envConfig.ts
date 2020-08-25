import { config } from "dotenv"

if (process.env?.NODE_ENV ?? 'development' == 'development') {
    config()
}

const PROJECT_ID = process.env.PROJECT_ID as string
const PRIVATE_KEY = (process.env.PRIVATE_KEY as string).replace(/\\n/g, '\n')
const CLIENT_EMAIL = process.env.CLIENT_EMAIL as string

export {
    PROJECT_ID,
    PRIVATE_KEY,
    CLIENT_EMAIL
}
