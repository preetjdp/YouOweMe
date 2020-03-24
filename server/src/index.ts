import express from 'express'
import {ApolloServer} from "apollo-server-express"

import {generateSchema} from "./schema"

const main = async () => {
const schema = await generateSchema()
const server = new ApolloServer({ schema });

const app = express()
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);

}

main()
