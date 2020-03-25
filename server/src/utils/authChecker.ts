import { AuthChecker, Root } from "type-graphql";
import { ApplicationContext } from "./appContext";

export const customAuthChecker: AuthChecker<ApplicationContext> = (
  { root, args, context, info },
  roles,
) => {
  if (!context.req.headers.authorization) {
    return false
  }
  console.log(context.req.headers.authorization)

  return true;
};