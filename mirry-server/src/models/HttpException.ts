import { StatusCodes } from "http-status-codes"

class HttpException extends Error {
    status: number
    details: object

    constructor(status: number = StatusCodes.INTERNAL_SERVER_ERROR, details: object = {}) {
        super()
        this.status = status
        this.details = details
    }
}

export default HttpException