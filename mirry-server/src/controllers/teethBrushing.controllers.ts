import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import MirrorSocketActions from "../models/MirrorSocketActions";
import { getMirrorSocket } from "../sockets/mirror.socket";

const started = async (req: Request, res: Response, next: NextFunction) => {
    const socket = await getMirrorSocket()

    if (socket) {
        socket.emit(MirrorSocketActions.BRUSHING_TEETH_STARTED)
        return res
            .status(StatusCodes.OK)
            .json()
    }

    next(new HttpException(StatusCodes.SERVICE_UNAVAILABLE))
}

const stoped = async (req: Request, res: Response, next: NextFunction) => {
    const socket = await getMirrorSocket()

    if (socket) {
        socket.emit(MirrorSocketActions.BRUSHING_TEETH_STOPED)
        return res
            .status(StatusCodes.OK)
            .json()
    }

    next(new HttpException(StatusCodes.SERVICE_UNAVAILABLE))
}

export {
    started,
    stoped
}