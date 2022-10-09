import { Router } from "express";
import authenticationRouter from "./routes/authentication.routes";
import todoRouter from "./routes/todo.routes";

const appRouter = Router()

appRouter.use('/auth', authenticationRouter)
appRouter.use('/todo', todoRouter)

export default appRouter