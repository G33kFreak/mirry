import { Router } from "express";
import { connectGoogle, login, refreshTokens, signup, uploadUserPhoto } from "../../controllers/authentication.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const authenticationRouter = Router()

authenticationRouter.post('/login', login)
authenticationRouter.post('/signup', uploadUserPhoto, signup)
authenticationRouter.post('/refresh-tokens', refreshTokens)

authenticationRouter.post('/google', authenticate, connectGoogle)

export default authenticationRouter