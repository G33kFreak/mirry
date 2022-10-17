import { Router } from "express";
import { login, refreshTokens, signup, uploadUserPhoto } from "../../controllers/authentication.controllers";

const authenticationRouter = Router()

authenticationRouter.post('/login', login)
authenticationRouter.post('/signup', uploadUserPhoto, signup)
authenticationRouter.post('/refresh-tokens', refreshTokens)

export default authenticationRouter