import { buildSchema, ResolverData } from "type-graphql"
import "reflect-metadata"

import { customAuthChecker } from "./utils/authChecker"
import { PubSubFire } from "./db/pubSubFire"
import { ApplicationContext } from "./utils/appContext"
import { Container } from "typedi"

/**
 * This function generates the schema for the API.
 */
const generateSchema = async () => {
    return await buildSchema({
        resolvers: [__dirname + '/modules/**/*.{ts,js}'],
        authChecker: customAuthChecker,
        dateScalarMode: "timestamp",
        pubSub: PubSubFire,
        container: (({ context }: ResolverData<ApplicationContext>) => Container.of(context.requestId))
    })
}

export {
    generateSchema
}