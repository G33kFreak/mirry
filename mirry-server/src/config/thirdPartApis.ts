import { AxiosRequestConfig } from "axios"
import env from "./env"

interface ThirdPardApiConfigs {
    polygon: AxiosRequestConfig
}

const thirdPartApiConfigs: ThirdPardApiConfigs = {
    polygon: {
        baseURL: 'https://api.polygon.io/v2',
        headers: {
            'Authorization': `Bearer ${env.POLYGON_API_KEY}`
        },
    }
}

export {
    ThirdPardApiConfigs,
    thirdPartApiConfigs,
}