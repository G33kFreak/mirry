import { Router } from "express";
import { getTrades } from "../../controllers/trades.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const tradesRouter = Router()

tradesRouter.get('/rates', authenticate, getTrades)

export default tradesRouter