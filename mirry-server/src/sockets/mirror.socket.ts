import { Server } from "socket.io"
import { Server as HttpServer } from "http"
import env from "../config/env"
import MirrorSocketActions from "../models/MirrorSocketActions"

let socketServer: Server

const setupMirrorSocket = (httpServer: HttpServer) => {
    socketServer = new Server(httpServer, { path: `/${env.MIRROR_API_KEY}` })
}

const getMirrorSocket = async () => {
    const sockets = await socketServer.fetchSockets()

    if (sockets.length > 0) {
        return sockets[0]
    }

    return null
}

export {
    setupMirrorSocket,
    getMirrorSocket
}