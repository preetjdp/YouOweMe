import { Resolver, FieldResolver, Int, Root } from "type-graphql";
import { Netting } from "../../models/Netting";
import { NettingOweType } from "../../models/Owe";

@Resolver(Netting)
export class NettingResolver {
    @FieldResolver(() => Int, {
        name: "oweMeAmount"
    })
    async oweMeAmountFieldResolver(@Root() netting: Netting) {

        let owes = netting.owes.filter((owe) => owe.oweType == NettingOweType.OWEME)
        if (owes.length == 0) {
            return 0
        }
        let oweMeAmount = owes.map((owe) => owe.amount).reduce((prev, curr) => prev + curr)
        return oweMeAmount
    }

    @FieldResolver(() => Int, {
        name: "iOweAmount"
    })
    async iOweAmountFieldResolver(@Root() netting: Netting) {

        let owes = netting.owes.filter((owe) => owe.oweType == NettingOweType.IOWE)
        if (owes.length == 0) {
            return 0
        }
        let iOweAmount = owes.map((owe) => owe.amount).reduce((prev, curr) => prev + curr)
        return iOweAmount
    }
}