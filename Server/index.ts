import express from "express";
import { createServer } from "http";
import path from 'path';


import Server = require("socket.io");


const app = express();
const httpServer = createServer(app);

///Sockets
export const io = new Server(httpServer, { /* options */ });
import "./sockets/socket";


require('dotenv').config();



//Path Publica
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));





httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});



