import { buildSchema } from "type-graphql"
import "reflect-metadata"

import { customAuthChecker } from "./utils/authChecker"
import { PubSubFire } from "./db/pubSubFire"


const generateSchema = async () => {
    return await buildSchema({
        resolvers: [__dirname + '/modules/**/*.{ts,js}'],
        authChecker: customAuthChecker,
        dateScalarMode: "timestamp",
        pubSub: PubSubFire
    })
}

export {
    generateSchema
}