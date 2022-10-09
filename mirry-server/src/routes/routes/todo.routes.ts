import { Router } from "express";
import { deleteList, getList, patchList, postList } from "../../controllers/todo.controllers";
import authenticate from "../../middleware/jwtAuthentication.middleware";

const todoRouter = Router()

todoRouter.get('/list', authenticate, getList)
todoRouter.post('/list', authenticate, postList)
todoRouter.patch('/list', authenticate, patchList)
todoRouter.delete('/list', authenticate, deleteList)

export default todoRouter