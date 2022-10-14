import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import MirrorSocketActions from "../models/MirrorSocketActions";
import { getMirrorSocket } from "../sockets/mirror.socket";
import { getMirrorSocketError } from "../utils/utils";

const started = async (req: Request, res: Response, next: NextFunction) => {
    const socket = await getMirrorSocket()

    if (socket) {
        socket.emit(MirrorSocketActions.BRUSHING_TEETH_STARTED)
        return res
            .status(StatusCodes.OK)
            .json()
    }

    next(getMirrorSocketError())
}

const stoped = async (req: Request, res: Response, next: NextFunction) => {
    const socket = await getMirrorSocket()

    if (socket) {
        socket.emit(MirrorSocketActions.BRUSHING_TEETH_STOPED)
        return res
            .status(StatusCodes.OK)
            .json()
    }

    next(getMirrorSocketError())
}

export {
    started,
    stoped
}