import * as userResolvers from './users'

const resolvers = {
    Query: {
      hello: () => 'Hello world!',
      add: async (_, { x, y }) => x + y,
      ...userResolvers
    },
  };

export {resolvers}