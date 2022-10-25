import axios, { AxiosInstance, AxiosRequestConfig, AxiosResponse } from "axios";
import { StatusCodes } from "http-status-codes";
import appCache, { ONE_HOUR_PERIOD } from "../config/cache";
import { thirdPartApiConfigs } from "../config/thirdPartApis";
import { GoogleTokens } from "../models/GoogleTokens";
import { ITokens } from "../models/Tokens";
import { refreshGoogleTokens } from "./googleAuth.repository";

const CALENDAR_CACHE_KEY = 'CALENDAR_CACHE_'

const setTokensToCache = (tokens: ITokens) => {
    appCache.set(`${CALENDAR_CACHE_KEY}${tokens.user}`, tokens, ONE_HOUR_PERIOD)
}

const onErrorInterceptor = async (error: any, userId: string) => {
    const originalRequest = error.config

    if (error.response.status == StatusCodes.UNAUTHORIZED) {
        const tokens = await GoogleTokens.findOne({ user: userId })
        if (tokens) {
            try {
                const newTokensResponse = await refreshGoogleTokens(tokens.refreshToken)
                const newTokens = new GoogleTokens({
                    accessToken: newTokensResponse.data.access_token,
                    refreshToken: tokens.refreshToken,
                    user: userId
                })

                setTokensToCache(newTokens)
                await newTokens.save()
                await tokens.remove()
                
                axios.defaults.headers.common['Authorization'] = `Bearer ${newTokens.accessToken}`
                return axios(originalRequest)
            } catch (e) {
                return Promise.reject(e)
            }
        }
    }

    return Promise.reject(error)
}

const onRequestInterceptor = async (request: AxiosRequestConfig, userId: string) => {
    var tokens: ITokens | undefined | null = appCache.get<ITokens>(`${CALENDAR_CACHE_KEY}${userId}`)

    if (tokens === undefined) {
        tokens = await GoogleTokens.findOne({ user: userId })
    }

    if (tokens) {
        request.headers!['Authorization'] = `Bearer ${tokens.accessToken}`
        setTokensToCache(tokens)

        return request
    } else {
        return Promise.reject('Authentication token not found')
    }
}

const getCalendarApiClient = (userId: string): AxiosInstance => {
    const client = axios.create(thirdPartApiConfigs.googleCalendar)

    client.interceptors.request.use((request) => onRequestInterceptor(request, userId))
    client.interceptors.response.use(undefined, (error) => onErrorInterceptor(error, userId))

    return client
}

const getCalendarsListFromApi = async (userId: string) => {
    return await getCalendarApiClient(userId).get('/users/me/calendarList')
}

export {
    getCalendarsListFromApi
}