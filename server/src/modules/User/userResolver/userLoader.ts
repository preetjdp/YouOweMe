import Container, { Service } from "typedi";
import DataLoader from "dataloader"
import { firestore } from "../../../db/firebase";
import { FieldPath, DocumentSnapshot, DocumentData } from "@google-cloud/firestore";
import { createParamDecorator } from "type-graphql";
import { ApplicationContext } from "../../../utils/appContext";

@Service()
/**
 * This is the User dataloader, which is used to fetch the user
 * in a humane manner using the dataloader package.
 */
export class UserDataLoader extends DataLoader<string, DocumentSnapshot | undefined> {
    constructor() {
        super(async (ids) => {
            console.log("Asked For ID's ", ids)
            const usersPromise: Promise<DocumentSnapshot<DocumentData>>[] = ids.map(async (id) => {
                return await firestore.collection('users').doc(id).get()
            })
            const users = await Promise.all(usersPromise)
            console.log("Dataloader Response", users.length)
            return ids.map((id) => users.find((user) => user.id === id));
        });
    }
}

/**
 * I have no idea what this does.
 * 
 * Is used to get the DI Container
 */
export function RequestContainer(): ParameterDecorator {
    return function (target: Object, propertyName: string | symbol, index: number) {
        return createParamDecorator<ApplicationContext>(({ context }) => {
            const paramtypes = Reflect.getMetadata('design:paramtypes', target, propertyName);
            const requestContainer = Container.of(context.requestId);
            return requestContainer.get(paramtypes[index]);
        })(target, propertyName, index);
    };
}