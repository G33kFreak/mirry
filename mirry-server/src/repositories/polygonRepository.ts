import axios, { AxiosInstance } from "axios"
import appCache from "../config/cache"
import { thirdPartApiConfigs } from "../config/thirdPartApis"
import CurrenciesPairs from "../models/CurrenciesPairs"
import TradeResult from "../models/CurrencyTrade"

const getPolygonApiClient = (): AxiosInstance => {
    return axios.create(thirdPartApiConfigs.polygon)
}

const formatDate = (date: Date): string => {
    return date.toISOString().split('T')[0]
}

const getCurrenciesTradesFromApi = async (pair: CurrenciesPairs) => {
    const today = new Date()
    const oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate())
    return await getPolygonApiClient().get<TradeResult>(
        `/aggs/ticker/${pair}/range/1/day/${formatDate(oneMonthAgo)}/${formatDate(today)}`
    )
}

const getCurrenciesTradesFromCache = (pair: CurrenciesPairs): TradeResult | undefined => {
    return appCache.get<TradeResult>(pair)
}

const saveCurrenciesTradesToCache = (tradesData: TradeResult): boolean => {
    const isSuccess = appCache.set(tradesData.ticker, tradesData)

    return isSuccess
}

export {
    getCurrenciesTradesFromApi,
    getCurrenciesTradesFromCache,
    saveCurrenciesTradesToCache
}