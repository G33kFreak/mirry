import multer from "multer";
import env from "./env";

const usersImagesStorage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, env.USERS_PHOTOS_DIR)
    },
    filename: (req, file, cb) => {
        cb(null, `${req.body.username}.png`)
    }
})

export default usersImagesStorage