import { StatusCodes } from "http-status-codes"
import HttpException from "../models/HttpException"

const getInternalError = (details: any) => {
    return new HttpException(
        StatusCodes.INTERNAL_SERVER_ERROR,
        details
    )
}

export {
    getInternalError
}