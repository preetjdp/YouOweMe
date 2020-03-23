import {gql} from "apollo-server-express"

const schema = gql`
type User {
    id: ID!,
    name: String!,
    image: String
}

type Query {
    hello: String,
    users: [User!]!
    user(id: ID!): User
    add(x: Int, y: Int): Int
  }
`

export {
    schema
}