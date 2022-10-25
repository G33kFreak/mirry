import { Router } from "express";
import { getCalendarsList } from "../../controllers/calendar.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";


const calendarRouter = Router()

calendarRouter.get('/list', authenticate, getCalendarsList)

export default calendarRouter