"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const http_1 = require("http");
const path_1 = __importDefault(require("path"));
const socket_io_1 = require("socket.io");
const app = (0, express_1.default)();
const httpServer = (0, http_1.createServer)(app);
const io = new socket_io_1.Server(httpServer, { /* options */});
require('dotenv').config();
///Sockets
io.on("connect", (socket) => {
    console.log("Cliente Conectado ");
    socket.on('disconnect', () => {
        console.log("Cliente Desconnectado");
    });
});
//Path Publica
const publicPath = path_1.default.resolve(__dirname, 'public');
app.use(express_1.default.static(publicPath));
httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});
