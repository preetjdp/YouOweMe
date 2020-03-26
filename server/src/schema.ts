import { gql } from "apollo-server-express"

import { buildSchema, Resolver, Query, Authorized } from "type-graphql"
import "reflect-metadata"

import { UserResolver } from "./modules/User/UserResolver"
import { customAuthChecker } from "./utils/authChecker"

// const schema = gql`
// type User {
//     id: ID!,
//     name: String!,
//     image: String
// }

// type Query {
//     hello: String,
//     users: [User!]!
//     user(id: ID!): User
//     add(x: Int, y: Int): Int
//   }
// `

@Resolver()
class HelloResolver {

    @Authorized()
    @Query(() => String)
    async hello() {
        return "Hello World"
    }
}

const generateSchema = async () => {
    return await buildSchema({
        resolvers: [__dirname + '/modules/**/*.ts'],
        authChecker: customAuthChecker,
        dateScalarMode: "timestamp"
    })
}

export {
    generateSchema
}