import { AxiosRequestConfig } from "axios"
import env from "./env"

const googleCredentials = require('../../credentials.json')

interface ThirdPardApiConfigs {
    polygon: AxiosRequestConfig,
    openWeatherMap: AxiosRequestConfig,
    googleAuth: AxiosRequestConfig,
    googleCalendar: AxiosRequestConfig,
}

const thirdPartApiConfigs: ThirdPardApiConfigs = {
    polygon: {
        baseURL: 'https://api.polygon.io/v2',
        headers: {
            'Authorization': `Bearer ${env.POLYGON_API_KEY}`
        },
    },
    openWeatherMap: {
        baseURL: 'https://api.openweathermap.org/data/2.5',
        params: {
            appId: env.OPENWEATHERMAP_API_KEY,
            units: 'metric',
        }
    },
    googleAuth: {
        baseURL: 'https://oauth2.googleapis.com/token',
        params: {
            client_secret: googleCredentials.web.client_secret,
            client_id: googleCredentials.web.client_id,
        },
    },
    googleCalendar: {
        baseURL: 'https://www.googleapis.com/calendar/v3',
    }
}

export {
    ThirdPardApiConfigs,
    thirdPartApiConfigs,
}