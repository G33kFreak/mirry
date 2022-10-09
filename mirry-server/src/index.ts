import bodyParser from "body-parser";
import express from "express";
import setupDatabase from "./config/mongoDb";
import httpExceptionMiddleware from "./middleware/httpException.middleware";
import appRouter from "./routes/router";

const app = express();
const port = 8000;

// Setup
setupDatabase()
app.use(bodyParser.json())

// Routes
app.use('/', appRouter)

// Middlewares
app.use(httpExceptionMiddleware)

app.listen(port, () => {
    console.info(`[server]: Server is running at http://localhost:${port}`);
});