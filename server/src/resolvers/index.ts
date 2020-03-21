import {firestore}  from '../db/firebase'

const resolvers = {
    Query: {
      hello: () => 'Hello world!',
      users: async () => {
        const usersRef = firestore.collection('users')
        const usersSnapshot = await usersRef.get()
        const users = usersSnapshot.docs.map((userSnapshot)=> {
         const user = {
           id: userSnapshot.id,
           ... userSnapshot.data()
         }
          return user
        })
        return users
      }
    },
  };

export {resolvers}