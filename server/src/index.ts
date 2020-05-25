import { ApolloServer } from "apollo-server"
import "./utils/envConfig"


import { generateSchema } from "./schema"
import { ApplicationContext } from "./utils/appContext"
import { Container } from "typedi"

const main = async () => {
  const schema = await generateSchema()
  const server = new ApolloServer({
    schema,
    introspection: true,
    playground: true,
    tracing: true,
    context: ({ req, connection }) => {
      const requestId = Math.floor(Math.random() * Number.MAX_SAFE_INTEGER);
      console.log('Creating Container', requestId)
      let context: ApplicationContext = {
        req,
        requestId
      }
      if (connection) {
        context = { ...context, ...connection.context }
      }
      return context
    },
    plugins: [
      {
        requestDidStart: () => ({
          willSendResponse(requestContext) {
            console.log('Disposing Container', requestContext.context.requestId)
            Container.reset(requestContext.context.requestId);
          },
        }),
      },
    ],
  });

  server.listen({ port: process.env.PORT || 4001 }, () =>
    console.log(`🚀 Server is ready at http://localhost:4000${server.graphqlPath}`)
  );

}

main()
