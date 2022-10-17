import { NextFunction, Request, Response } from "express";
import jsonwebtoken, { JwtPayload } from "jsonwebtoken"
import env from "../config/env";
import { getUnauthorizedException, isTokenExpired } from "../utils/authentication.utils";

const authenticate = (req: Request, res: Response, next: NextFunction) => {
    const accessToken = req.headers['authorization']

    if (accessToken == env.MIRROR_API_KEY) {
        return next()
    }

    if (accessToken) {
        try {
            const verifiedToken = jsonwebtoken.verify(accessToken, env.SECRET_HASH) as JwtPayload

            if (isTokenExpired(verifiedToken.exp!)) {
                next(getUnauthorizedException())
            }

            req.headers['user'] = verifiedToken.user
            next()
        } catch (e) {
            next(getUnauthorizedException())
        }
    } else {
        next(getUnauthorizedException())
    }
}

export default authenticate