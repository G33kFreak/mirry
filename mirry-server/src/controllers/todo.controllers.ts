import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import HttpException from "../models/HttpException";
import { ITodoItem, TodoItem } from "../models/TodoItem";
import { getInternalError } from "../utils/utils";

const getList = async (req: Request, res: Response, next: NextFunction) => {
    const { page, limit } = req.query

    try {
        const _limit = Number(limit ?? 1)
        const _page = Number(page ?? 0)

        const itemsCount = await TodoItem.count()
        const totalPages = Math.ceil(itemsCount / _limit) - 1

        const items = await TodoItem.find({ user: req.headers['user'] })
            .limit(_limit)
            .skip(_page * _limit)
            .sort({ createdAt: 'asc'})

        return res
            .status(StatusCodes.OK)
            .json({
                page: _page,
                lastPage: totalPages,
                items
            })

    } catch (e) {
        next(getInternalError(e))
    }
}

const postList = async (req: Request<any, ITodoItem>, res: Response, next: NextFunction) => {
    try {
        const todoItem: ITodoItem = req.body

        if (todoItem) {
            const newItem = new TodoItem({
                ...todoItem,
                user: req.headers['user']
            })
            await newItem.save()

            return res
                .status(StatusCodes.CREATED)
                .json(newItem)
        }
    } catch (e) {
        next(new HttpException(
            StatusCodes.BAD_REQUEST,
            { details: e }
        ))
    }
}

const patchList = async (req: Request<any, ITodoItem>, res: Response, next: NextFunction) => {
    try {
        const todoItem: ITodoItem = req.body
        await TodoItem.updateOne({ _id: todoItem.id }, { ...todoItem })

        return res
            .status(StatusCodes.OK)
            .json()

    } catch (e) {
        next(new HttpException(
            StatusCodes.BAD_REQUEST,
            { details: e }
        ))
    }
}

const deleteList = async (req: Request, res: Response) => {
    const { id } = req.body

    try {
        await TodoItem.deleteOne({ _id: id })

        return res
            .status(StatusCodes.ACCEPTED)
            .json()
    } catch (e) {
        return res
            .status(StatusCodes.NO_CONTENT)
            .json()
    }
}

export {
    getList,
    postList,
    patchList,
    deleteList
}