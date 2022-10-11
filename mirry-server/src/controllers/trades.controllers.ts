import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import CurrenciesPairs from "../models/CurrenciesPairs";
import { getCurrenciesTradesFromApi, getCurrenciesTradesFromCache, saveCurrenciesTradesToCache } from "../repositories/polygonRepository";
import { getInternalError } from "../utils/utils";

const getTrades = async (req: Request, res: Response, next: NextFunction) => {
    const pair = req.query.pair as CurrenciesPairs

    try {
        const resultFromCache = getCurrenciesTradesFromCache(pair)

        if (resultFromCache) {
            return res
                .status(StatusCodes.OK)
                .json(resultFromCache)
        }

        const result = await getCurrenciesTradesFromApi(pair)
        saveCurrenciesTradesToCache(result.data)

        return res
            .status(StatusCodes.OK)
            .json(result.data)
    } catch (e) {
        next(getInternalError(e))
    }
}

export {
    getTrades
}