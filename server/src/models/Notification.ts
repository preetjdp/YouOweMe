import { InterfaceType, Field, ID, ObjectType, createUnionType, registerEnumType } from "type-graphql";
import { Owe } from "./Owe";

export const NotificationUnion = createUnionType({
    name: "NotificationUnion",
    types: () => [NewOweNotification] as const
});

@InterfaceType()
abstract class Notification {
    @Field(() => ID)
    id: string

    @Field()
    title: string

    @Field()
    body: string

    @Field(() => NotificationType)
    type: NotificationType

    @Field()
    created: Date
}

enum NotificationType {
    NEWOWE
}

registerEnumType(NotificationType, {
    name: "NotificationType",
    description: "Defines the type of a `Notification`."
})

@ObjectType({ implements: Notification })
class NewOweNotification extends Notification {
    @Field(() => Owe)
    owe: Owe
}
