import axios, { AxiosInstance } from "axios"
import { thirdPartApiConfigs } from "../config/thirdPartApis"


const getGoogleAuthApiClient = (): AxiosInstance => {
    return axios.create(thirdPartApiConfigs.googleAuth)
}

const getGoogleTokens = async (authCode: string) => {
    return await getGoogleAuthApiClient().post('',
        {
            redirect_uri: '',
            code: authCode,
            grant_type: 'authorization_code'
        }
    )
}

const refreshGoogleTokens = async (refreshToken: string) => {
    return await getGoogleAuthApiClient().post('',
        {
            grant_type: 'refresh_token',
            refresh_token: refreshToken
        }
    )
}

export {
    getGoogleTokens,
    refreshGoogleTokens
}

