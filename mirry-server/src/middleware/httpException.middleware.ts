import { NextFunction, Request, Response } from "express";
import HttpException from "../models/HttpException";

const httpExceptionMiddleware = (httpException: HttpException, req: Request, res: Response, next: NextFunction) => {
    const status = httpException.status
    const details = httpException.details

    return res
        .status(status)
        .json(details)
}

export default httpExceptionMiddleware