import { model, Schema } from "mongoose";
import { ITokens } from "./Tokens";

const googleTokensSchema = new Schema({
    accessToken: String,
    refreshToken: String,
    user: {
        ref: 'User',
        type: Schema.Types.ObjectId
    }
}, { versionKey: false })

const GoogleTokens = model<ITokens>('GoogleTokens', googleTokensSchema)

export {
    GoogleTokens
}