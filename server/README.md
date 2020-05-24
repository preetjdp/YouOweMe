# You Owe Me Server

The Backend Server which acts as a middleware
between the the consumer facing applications 
and the services.

Given Graphql is being used here the appliction is supposed to be self deocumenting,
meaning logic, reasoning for a mutation / query should be in t Graphql.

> Try out the [seva api.](https://api.youoweme.preetjdp.dev/) 

# Resources
1. [Ben Awad's Benchmarking GraphQL Node.js Servers](https://www.youtube.com/watch?v=JbV7MCeEPb8)
2. [Fireship.io Apollo Graphql](https://www.youtube.com/watch?v=8D9XnnjFGMs)

# Things Being Used
1. [TypeGraphql](https://github.com/MichalLytek/type-graphql) : 
    To generate Gql Types from Typescript Types.
2. Typescript : Beacuse Typescript is amazing.
3. Firebase : For Firestore and Auth.

# Get Things Running
1. Add the Environment Variables as follows
``` env
PROJECT_ID=
PRIVATE_KEY=""
CLIENT_EMAIL=
```
2. Run the Project with
```bash
// The server will run at Port 4000
npm run start:dev
```