import { Router } from "express";
import authenticationRouter from "./routes/authentication.routes";
import recognitionRouter from "./routes/recognition.routes";
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

export default appRouter