import {firestore}  from '../db/firebase'

const users = async () => {
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

const user =  async (_,{id}) => {
    const userRef = firestore.collection('users').doc(id)
    const userSnapshot = await userRef.get()
    if(!userSnapshot.exists) {
      //TODO return Apollo Error
      return null
    }
    const userData = userSnapshot.data()
    const userDataModified = {
      id: userSnapshot.id,
      ... userData
    }
    return userDataModified
}


export {
    user,
    users
}