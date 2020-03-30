// import { ApolloServer } from "apollo-server-express"
import {ApolloServer} from "apollo-server"
import "./utils/envConfig"


import { generateSchema } from "./schema"

const main = async () => {
  const schema = await generateSchema()
  const server = new ApolloServer({
    schema,
    context: ({ req }) => ({ req })
  });

  server.listen({ port: process.env.PORT || 4000 }, () =>
    console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
  );

}

main()
