import { Router } from "express";
import { started, stoped } from "../../controllers/teethBrushing.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const teethBrushingRouter = Router()

teethBrushingRouter.post('/started', authenticate, started)
teethBrushingRouter.post('/stoped', authenticate, stoped)

export default teethBrushingRouter