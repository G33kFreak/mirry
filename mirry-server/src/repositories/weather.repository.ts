import axios, { AxiosInstance } from "axios";
import appCache, { ONE_HOUR_PERIOD } from "../config/cache";
import { thirdPartApiConfigs } from "../config/thirdPartApis";
import CurrentWeather from "../models/CurrentWeather";

const WEATHER_CACHE_KEY = 'CURRENT_WEATHER'

const getWeatherApiClient = (): AxiosInstance => {
    return axios.create(thirdPartApiConfigs.openWeatherMap)
}

const getCurrentWeatherFromApi = async (lat: number, lon: number) => {
    return await getWeatherApiClient().get<CurrentWeather>('/weather', {
        params: {
            lat,
            lon
        }
    })
}

const getCurrentWeatherFromCache = () => {
    return appCache.get<CurrentWeather>(WEATHER_CACHE_KEY)
}

const saveCurrentWeatherToCache = (weather: CurrentWeather) => {
    const isSuccess = appCache.set(WEATHER_CACHE_KEY, weather, ONE_HOUR_PERIOD)

    return isSuccess
}

export {
    getCurrentWeatherFromApi,
    getCurrentWeatherFromCache,
    saveCurrentWeatherToCache
}