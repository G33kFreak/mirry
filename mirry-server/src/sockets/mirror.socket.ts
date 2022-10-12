import { Server } from "socket.io"
import { Server as HttpServer } from "http"
import env from "../config/env"
import MirrorSocketActions from "../models/MirrorSocketActions"

let socketServer: Server

const setupMirrorSocket = (httpServer: HttpServer) => {
    socketServer = new Server(httpServer, { path: `/${env.MIRROR_API_KEY}` })

    socketServer.on(MirrorSocketActions.CONNECTION, (socket) => {
        console.log('connected scoket')
    })
}

export {
    setupMirrorSocket,
    socketServer
}