import * as dotenv from 'dotenv'

dotenv.config()

const env = {
    SECRET_HASH: process.env.SECRET_HASH!,
    POLYGON_API_KEY: process.env.POLYGON_API_KEY!
}

export default env