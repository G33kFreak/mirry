import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import MirrorSocketActions from "../models/MirrorSocketActions";
import { User } from "../models/User";
import { UserSettings } from "../models/UserSettings";
import { getMirrorSocket } from "../sockets/mirror.socket";
import { getInternalError, getMirrorSocketError } from "../utils/utils";

const userRecognized = async (req: Request, res: Response, next: NextFunction) => {
    const { username } = req.body

    try {
        const user = await User.findOne({ username }).select('-password')
        const settings = await UserSettings.findOne({ user: user?.id }).select('-user')
        const socket = await getMirrorSocket()

        if (user == null || settings == null) {
            return next(new HttpException(
                StatusCodes.NOT_FOUND,
                { username: "Doesn't exists" }
            ))
        }

        if (socket == null) {
            return next(getMirrorSocketError())
        }

        socket!.emit(MirrorSocketActions.FACE_RECOGNIZED, {
            user,
            settings
        })

        return res
            .status(StatusCodes.OK)
            .json()
    } catch (e) {
        next(getInternalError(e))
    }
}

const userLeft = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const socket = await getMirrorSocket()

        if (socket) {
            socket.emit(MirrorSocketActions.RECOGNIZED_USER_LEFT)
            return res
                .status(StatusCodes.OK)
                .json()
        }

        next(getMirrorSocketError())
    } catch (e) {
        next(getMirrorSocketError())
    }
}

export {
    userRecognized,
    userLeft
}