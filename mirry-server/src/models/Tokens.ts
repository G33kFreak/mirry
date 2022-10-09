import { model, Schema } from "mongoose";

interface ITokens {
    id: string
    accessToken: string
    refreshToken: string
    user: string
}

const tokensSchema = new Schema({
    accessToken: String,
    refreshToken: String,
    user: {
        ref: 'User',
        type: Schema.Types.ObjectId
    }
}, { versionKey: false })

const Tokens = model<ITokens>('Tokens', tokensSchema)

export {
    ITokens,
    Tokens
}