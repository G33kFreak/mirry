import { model, Schema } from "mongoose"
import CurrenciesPairs from "./CurrenciesPairs"

interface ITodoSettings {
    amountToShow: number
}

interface ICurrenciesSettings {
    pairsToShow: CurrenciesPairs[],
}

interface IUserSettings {
    id: string,
    user: string,
    todo: ITodoSettings,
    currencies: ICurrenciesSettings,
}

const settingsSchema = new Schema({
    user: {
        ref: 'User',
        type: Schema.Types.ObjectId,
    },
    todo: {
        amountToShow: {
            type: Number,
            default: 5,
        },
    },
    currencies: {
        pairsToShow: {
            type: [String],
            default: [CurrenciesPairs.EUR_USD]
        }
    },
    calendar: {
        email: String,
    },
}, { versionKey: false })

const UserSettings = model<IUserSettings>('UserSettings', settingsSchema)

export {
    UserSettings,
    ICurrenciesSettings,
    ITodoSettings,
    IUserSettings,
}