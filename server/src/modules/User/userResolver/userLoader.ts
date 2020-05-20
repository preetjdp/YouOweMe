import Container, { Service } from "typedi";
import DataLoader from "dataloader"
import { firestore } from "../../../db/firebase";
import { FieldPath, DocumentSnapshot, DocumentData } from "@google-cloud/firestore";
import { createParamDecorator } from "type-graphql";
import { ApplicationContext } from "../../../utils/appContext";

@Service()
export class UserDataLoader extends DataLoader<string, DocumentSnapshot | undefined> {
    constructor() {
        super(async (ids) => {
            console.log("Asked For ID's ",ids)
            const usersPromise: Promise<DocumentSnapshot<DocumentData>>[] = ids.map(async (id) => {
                return await firestore.collection('users').doc(id).get()
            })
            const users = await Promise.all(usersPromise)
            console.log("Dataloader Response", users.length)
            return ids.map((id) => users.find((user) => user.id === id));
        });
    }
}

export function RequestContainer(): ParameterDecorator {
    return function (target: Object, propertyName: string | symbol, index: number) {
        return createParamDecorator<ApplicationContext>(({ context, info }) => {
            const paramtypes = Reflect.getMetadata('design:paramtypes', target, propertyName);
            const requestContainer = Container.of(context.requestId);
            return requestContainer.get(paramtypes[index]);
        })(target, propertyName, index);
    };
}