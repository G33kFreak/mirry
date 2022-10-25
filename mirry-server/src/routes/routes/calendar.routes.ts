import { Router } from "express";
import { getCalendarsList, getWeekEventsList } from "../../controllers/calendar.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";



const calendarRouter = Router()

calendarRouter.get('/list', authenticate, getCalendarsList)
calendarRouter.get('/events', authenticate, getWeekEventsList)

export default calendarRouter