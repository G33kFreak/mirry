import { Router } from "express";
import { getSettings, patchSettings } from "../../controllers/settings.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const settingsRouter = Router()

settingsRouter.get('', authenticate, getSettings)
settingsRouter.patch('', authenticate, patchSettings)

export default settingsRouter