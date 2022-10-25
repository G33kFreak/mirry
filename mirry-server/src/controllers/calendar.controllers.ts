import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { getCalendarsListFromApi, getEventsListFromApi } from "../repositories/calendar.repository";
import { getMonday, getSunday } from "../utils/calendar.utils";
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

const getWeekEventsList = async (req: Request, res: Response, next: NextFunction) => {
    const { user } = req.headers

    try {
        const calendarId: string = req.query.calendarId as string
        const eventsResponse = (await getEventsListFromApi(calendarId, user as string, getMonday(), getSunday())).data
        
        return res
            .status(StatusCodes.OK)
            .json(eventsResponse.items)
    } catch (e) {
        return next(getInternalError(e))
    }
}

export {
    getCalendarsList,
    getWeekEventsList
}