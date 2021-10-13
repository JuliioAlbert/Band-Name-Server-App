"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.io = void 0;
const express_1 = __importDefault(require("express"));
const http_1 = require("http");
const path_1 = __importDefault(require("path"));
const Server = require("socket.io");
const app = (0, express_1.default)();
const httpServer = (0, http_1.createServer)(app);
///Sockets
exports.io = new Server(httpServer, { /* options */});
require("./sockets/socket");
require('dotenv').config();
//Path Publica
const publicPath = path_1.default.resolve(__dirname, 'public');
app.use(express_1.default.static(publicPath));
httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});
