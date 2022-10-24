import { AxiosRequestConfig } from "axios"
import env from "./env"

interface ThirdPardApiConfigs {
    polygon: AxiosRequestConfig,
    openWeatherMap: AxiosRequestConfig,
    googleAuth: AxiosRequestConfig,
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
        params: {
            key: env.GOOGLE_API_KEY,
        }
    }
}

export {
    ThirdPardApiConfigs,
    thirdPartApiConfigs,
}