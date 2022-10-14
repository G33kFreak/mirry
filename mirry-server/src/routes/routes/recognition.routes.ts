import { Router } from "express";
import { userLeft, userRecognized } from "../../controllers/recognition.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const recognitionRouter = Router()

recognitionRouter.post('/recognized', authenticate, userRecognized)
recognitionRouter.post('/left', authenticate, userLeft)

export default recognitionRouter