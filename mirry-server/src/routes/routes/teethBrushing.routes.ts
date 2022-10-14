import { Router } from "express";
import { started } from "../../controllers/teethBrushing.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const teethBrushingRouter = Router()

teethBrushingRouter.post('/started', authenticate, started)

export default teethBrushingRouter