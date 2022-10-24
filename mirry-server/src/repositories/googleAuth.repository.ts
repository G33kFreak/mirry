import axios, { AxiosInstance } from "axios"
import env from "../config/env"
import { thirdPartApiConfigs } from "../config/thirdPartApis"
import { ITokens } from "../models/Tokens"

const getGoogleAuthApiClient = (): AxiosInstance => {
    return axios.create(thirdPartApiConfigs.googleAuth)
}

const getRefreshToken = async (idToken: string) => {
    return await getGoogleAuthApiClient().post(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithIdp',
        {
            requestUri: env.GOOGLE_REQUEST_URI,
            postBody: `id_token=${idToken}&providerId=google.com`,
            returnIdpCredential: true,
            returnSecureToken: true
        }
    )
}

const refreshGoogleTokens = async (refreshToken: string) => {
    return await getGoogleAuthApiClient().post(
        'https://securetoken.googleapis.com/v1/token',
        {
            grant_type: 'refresh_token',
            refresh_token: refreshToken
        }
    )
}

export {
    getRefreshToken,
    refreshGoogleTokens
}

