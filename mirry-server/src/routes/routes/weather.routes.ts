import { Router } from "express";
import { getCurrentWeather } from "../../controllers/weather.controllers";

const weatherRouter = Router()

weatherRouter.get('/current', getCurrentWeather)

export default weatherRouter