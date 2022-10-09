import { model, Schema } from "mongoose";

interface ITodoItem {
    id: string
    title: string
    description?: string
    isDone: boolean
    user: string
    createdAt: Date
}

const todoItemSchema = new Schema({
    title: {
        type: String,
        required: true
    },
    description: String,
    isDone: {
        type: Boolean,
        default: false
    },
    user: {
        ref: 'User',
        type: Schema.Types.ObjectId
    },
    createdAt: {
        type: Date,
        default: Date.now
    }
}, { versionKey: false })

const TodoItem = model<ITodoItem>('TodoItem', todoItemSchema)

export {
    TodoItem,
    ITodoItem
}