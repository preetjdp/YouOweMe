import { AuthChecker } from "type-graphql";
import { ApplicationContext } from "./appContext";

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