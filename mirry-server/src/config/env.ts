import * as dotenv from 'dotenv'

dotenv.config()

const env = {
    SECRET_HASH: process.env.SECRET_HASH!,
    POLYGON_API_KEY: process.env.POLYGON_API_KEY!,
    OPENWEATHERMAP_API_KEY: process.env.OPENWEATHERMAP_API_KEY!,
    MIRROR_API_KEY: process.env.MIRROR_API_KEY!,
    USERS_PHOTOS_DIR: process.env.USERS_PHOTOS_DIR!,
}

export default env