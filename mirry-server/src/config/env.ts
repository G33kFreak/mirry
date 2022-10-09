import * as dotenv from 'dotenv'

dotenv.config()

const env = {
    SECRET_HASH: process.env.SECRET_HASH!
}

export default env