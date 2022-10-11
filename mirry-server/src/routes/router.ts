import { Router } from "express";
import authenticationRouter from "./routes/authentication.routes";
import todoRouter from "./routes/todo.routes";
import tradesRouter from "./routes/trades.routes";

const appRouter = Router()

appRouter.use('/auth', authenticationRouter)
appRouter.use('/todo', todoRouter)
appRouter.use('/trades', tradesRouter)

export default appRouter