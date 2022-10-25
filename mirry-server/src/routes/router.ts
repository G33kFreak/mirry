import { Router } from "express";
import authenticationRouter from "./routes/authentication.routes";
import calendarRouter from "./routes/calendar.routes";
import recognitionRouter from "./routes/recognition.routes";
import settingsRouter from "./routes/settings.routes";
import teethBrushingRouter from "./routes/teethBrushing.routes";
import todoRouter from "./routes/todo.routes";
import tradesRouter from "./routes/trades.routes";
import weatherRouter from "./routes/weather.routes";

const appRouter = Router()

appRouter.use('/auth', authenticationRouter)
appRouter.use('/todo', todoRouter)
appRouter.use('/trades', tradesRouter)
appRouter.use('/weather', weatherRouter)
appRouter.use('/brushing', teethBrushingRouter)
appRouter.use('/recognition', recognitionRouter)
appRouter.use('/settings', settingsRouter)
appRouter.use('/calendar', calendarRouter)

export default appRouter