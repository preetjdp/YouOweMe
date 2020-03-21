import {gql} from "apollo-server-express"

const schema = gql`
type User {
    id: ID!,
    name: String
}

type Query {
    hello: String,
    users: [User!]!
  }
`

export {
    schema
}