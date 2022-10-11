import { Router } from "express";
import { getCurrentWeather } from "../../controllers/weather.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const weatherRouter = Router()

weatherRouter.get('/current', authenticate, getCurrentWeather)

export default weatherRouter