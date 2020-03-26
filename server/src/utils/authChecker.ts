import { AuthChecker } from "type-graphql";
import { ApplicationContext } from "./appContext";

export const customAuthChecker: AuthChecker<ApplicationContext> = (
  {
    // root,
    // args,
    context,
    // info
  },
  // roles,
) => {
  if (!context.req.headers.authorization) {
    return false
  }

  return true;
};