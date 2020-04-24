import { ApolloServer } from "apollo-server"
import "./utils/envConfig"


import { generateSchema } from "./schema"

const main = async () => {
  const schema = await generateSchema()
  const server = new ApolloServer({
    schema,
    introspection: true,
    playground: true,
    tracing: true,
    context: ({ req, connection }) => {
      if (connection) {
        return connection.context
      }
      return { req }
    }
  });

  server.listen({ port: process.env.PORT || 4000 }, () =>
    console.log(`🚀 Server is ready at http://localhost:4000${server.graphqlPath}`)
  );

}

main()
