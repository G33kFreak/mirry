import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { getCalendarsListFromApi } from "../repositories/calendar.repository";
import { getInternalError } from "../utils/utils";

const getCalendarsList = async (req: Request, res: Response, next: NextFunction) => {
    const { user } = req.headers

    try {
        const calendarsList = (await getCalendarsListFromApi(user as string)).data

        return res
            .status(StatusCodes.OK)
            .json(calendarsList)
    } catch (e) {
        return next(getInternalError(e))
    }
}

export {
    getCalendarsList
}