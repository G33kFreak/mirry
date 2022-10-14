import { StatusCodes } from "http-status-codes"
import HttpException from "../models/HttpException"

const getInternalError = (details: any) => {
    return new HttpException(
        StatusCodes.INTERNAL_SERVER_ERROR,
        details
    )
}

const getMirrorSocketError = () => {
    return new HttpException(
        StatusCodes.SERVICE_UNAVAILABLE,
        {socket:"Mirror socket is not available"}
    )
}

export {
    getInternalError,
    getMirrorSocketError
}