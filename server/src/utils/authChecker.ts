import { AuthChecker } from "type-graphql";
import { ApplicationContext } from "./appContext";
import { auth } from "../db/firebase";

export const customAuthChecker: AuthChecker<ApplicationContext> = async (
  {
    context,
  },
) => {
  let userId = context.req.headers.authorization
  if (!userId) {
    return false
  }

  try {
    const user = await auth.getUser(userId)
    if (user) {
      return true
    }
    throw ("User ID is null")
  } catch (e) {
    return false
  }
};