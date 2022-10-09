import mongoose from "mongoose"

const setupDatabase = () => {
    const mongoDbUrl = 'mongodb://127.0.0.1:27017'
    mongoose.connect(mongoDbUrl)

    const database = mongoose.connection

    mongoose.set('toJSON', {
        virtuals: true,
        transform: (_, converted) => {
            let obj = converted
            obj.id = converted._id
            delete obj._id
            return obj
        }
    })

    database.on('error', (e) => {
        console.error(e)
    })

    database.once('connected', () => {
        console.info('Database connected')
    })
}

export default setupDatabase