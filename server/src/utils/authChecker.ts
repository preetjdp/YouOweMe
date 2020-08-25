import { AuthChecker } from "type-graphql";
import { ApplicationContext } from "./appContext";

/**
 * This function is used to verify weather the user
 * is authorized to make the query or not.
 */
export const customAuthChecker: AuthChecker<ApplicationContext> = async (
  {
    context,
  },
) => {
  let userId = context.req.headers.authorization
  if (!userId) {
    return false
  }
  return true
};