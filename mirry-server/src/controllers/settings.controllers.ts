import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import { IUserSettings, UserSettings } from "../models/UserSettings";
import { getInternalError } from "../utils/utils";

const getSettings = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const user = req.headers['user']
        const settings = await UserSettings.findOne({ user }).select('-user')

        return res
            .status(StatusCodes.OK)
            .json(settings)
    } catch (e) {
        return next(getInternalError(e))
    }
}

const patchSettings = async (req: Request, res: Response, next: NextFunction) => {
    try {
        const newSettings: IUserSettings = req.body
        const user = req.headers['user']

        const updated = await UserSettings
            .findByIdAndUpdate({ user: user }, { ...newSettings }, { new: true })
            .select('-user')

        return res
            .status(StatusCodes.OK)
            .json(updated)
    } catch (e) {
        return next(new HttpException(
            StatusCodes.BAD_REQUEST,
            { details: e }
        ))
    }
}


export {
    getSettings,
    patchSettings
}