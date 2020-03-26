import express from 'express'
import { ApolloServer } from "apollo-server-express"
import "./utils/envConfig"


import { generateSchema } from "./schema"

const main = async () => {
  const schema = await generateSchema()
  const server = new ApolloServer({
    schema,
    context: ({ req }) => ({ req })
  });

  const app = express()
  server.applyMiddleware({ app , path: '/wow'});

  app.listen({ port: process.env.PORT || 4000 }, () =>
    console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
  );

}

main()
