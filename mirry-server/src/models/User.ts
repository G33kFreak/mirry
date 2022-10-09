import { model, Schema } from "mongoose";

interface IUser {
    id: string
    username: string
    password: string
}

const userSchema = new Schema({
    username: {
        type: String,
        unique: true
    },
    password: String
}, { versionKey: false })

const User = model<IUser>('User', userSchema)

export {
    IUser,
    User
}