import { StatusCodes } from "http-status-codes"
import jsonwebtoken from "jsonwebtoken"
import { Types } from "mongoose"
import env from "../config/env"
import { ACCESS_TOKEN_EXPIRE_TIME, REFRESH_TOKEN_EXPIRE_TIME } from "../config/jwtAuth"
import HttpException from "../models/HttpException"
import { ITokens, Tokens } from "../models/Tokens"

const validatePassword = (password: string): boolean => {
    /*
        At least one upper case English letter, (?=.*?[A-Z])
        At least one lower case English letter, (?=.*?[a-z])
        At least one digit, (?=.*?[0-9])
        Minimum eight in length .{8,} (with the anchors)
    */
    const regularExp = new RegExp("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$")
    return regularExp.test(password)
}

const generateJwt = async (uuid: Types.ObjectId): Promise<ITokens> => {
    await Tokens.deleteMany({ user: uuid })

    const accessToken = jsonwebtoken.sign({ user: uuid }, env.SECRET_HASH, { expiresIn: ACCESS_TOKEN_EXPIRE_TIME })
    const refreshToken = jsonwebtoken.sign({ user: uuid }, env.SECRET_HASH, { expiresIn: REFRESH_TOKEN_EXPIRE_TIME })

    const tokens = new Tokens({ accessToken, refreshToken, user: uuid })
    await tokens.save()

    return tokens.toObject()
}

const isTokenExpired = (expiration: number): boolean => {
    const isExpired = Date.now() >= expiration * 1000

    return isExpired
}

const getUnauthorizedException = (): HttpException => {
    return new HttpException(
        StatusCodes.UNAUTHORIZED,
        { details: "Wrong password, username or access token" }
    )
}

const getTokenExpiredException = (): HttpException => {
    return new HttpException(
        StatusCodes.UNAUTHORIZED,
        { details: "Token is expired" }
    )
}

export {
    validatePassword,
    generateJwt,
    isTokenExpired,
    getUnauthorizedException,
    getTokenExpiredException,
}