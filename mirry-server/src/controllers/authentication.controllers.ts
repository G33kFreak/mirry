import { NextFunction, Request, Response } from "express"
import { StatusCodes } from "http-status-codes"
import HttpException from "../models/HttpException"
import { User } from "../models/User"
import { generateJwt, getTokenExpiredException, getUnauthorizedException, isTokenExpired, validatePassword } from "../utils/authentication.utils"
import bcrypt from 'bcrypt'
import { Tokens } from "../models/Tokens"
import { getInternalError } from "../utils/utils"
import jsonwebtoken from "jsonwebtoken"

const refreshTokens = async (req: Request, res: Response, next: NextFunction) => {
    const { refreshToken } = req.body

    try {
        const currentTokens = Tokens.exists({ refreshToken })

        if (currentTokens === null) {
            next(getUnauthorizedException())
        }

        const refreshDecoded = jsonwebtoken.decode(refreshToken) as jsonwebtoken.JwtPayload
        if (isTokenExpired(refreshDecoded.exp!)) {
            next(getTokenExpiredException())
        }

        const newTokens = await generateJwt(refreshDecoded.user)

        return res
            .status(StatusCodes.OK)
            .json(newTokens)

    } catch (e) {
        next(getInternalError(e))
    }
}

const login = async (req: Request, res: Response, next: NextFunction) => {
    const { username, password } = req.body

    const user = await User.findOne({ username })

    if (user !== null) {
        const isPasswordCorrect = await bcrypt.compare(password, user.password!)

        if (!isPasswordCorrect) {
            next(getUnauthorizedException())
        }

        try {
            const tokens = await generateJwt(user._id)
            return res
                .status(StatusCodes.OK)
                .json(tokens)
        } catch (e) {
            next(getInternalError(e))
        }
    }

    // const accessToken = jsonwebtoken.sign(user?._id, env.SECRET_HASH, )

    return next(getUnauthorizedException())
}

const signup = async (req: Request, res: Response, next: NextFunction) => {
    const { username, password } = req.body

    try {
        if (!validatePassword(password)) {
            throw new HttpException(
                StatusCodes.BAD_REQUEST,
                { password: 'Minimum 8 characters at least 1 Alphabet and 1 Number' }
            )
        }

        const encryptedPassword = await bcrypt.hash(password, 10)

        const newUser = new User({
            username,
            password: encryptedPassword
        })
        await newUser.save()

        return res
            .status(StatusCodes.CREATED)
            .json(req.body)
    } catch (error: any) {
        if (error instanceof HttpException) {
            return next(error)
        }

        return next(
            new HttpException(
                StatusCodes.UNPROCESSABLE_ENTITY,
                { username: "Already exists" }
            )
        )
    }
}

export {
    refreshTokens,
    login,
    signup
}