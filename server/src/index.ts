import express from 'express'
import {ApolloServer} from "apollo-server-express"

import {schema} from "./schema"
import {resolvers} from "./resolvers/"

const server = new ApolloServer({ typeDefs: schema, resolvers });

const app = express()
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);