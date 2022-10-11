import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import { getCurrentWeatherFromApi, getCurrentWeatherFromCache, saveCurrentWeatherToCache } from "../repositories/weather.repository";
import { getInternalError } from "../utils/utils";

const getCurrentWeather = async (req: Request, res: Response, next: NextFunction) => {
    const lat = Number(req.query.lat)
    const lon = Number(req.query.lon)

    try {
        const resultFromCache = getCurrentWeatherFromCache()

        if (lat && lon) {

            if (resultFromCache) {
                return res
                    .status(StatusCodes.OK)
                    .json(resultFromCache)
            }

            const result = await getCurrentWeatherFromApi(lat, lon)
            saveCurrentWeatherToCache(result.data)

            return res
                .status(StatusCodes.OK)
                .json(result.data)

        } else {
            next(new HttpException(StatusCodes.BAD_REQUEST))
        }
    } catch (e) {
        next(getInternalError(e))
    }
}

export {
    getCurrentWeather
}