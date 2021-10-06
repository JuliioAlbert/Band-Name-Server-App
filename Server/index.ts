import express from "express";
import { createServer } from "http";
import path from 'path';

import { Server } from "socket.io";

const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, { /* options */ });


require('dotenv').config();


///Sockets


io.on("connect", (socket) => {
   console.log("Cliente Conectado ");

   socket.on('disconnect', () => { 
    console.log("Cliente Desconnectado");
   });
  });



//Path Publica
const publicPath = path.resolve(__dirname, 'public');
app.use(express.static(publicPath));





httpServer.listen(process.env.PORT, () => {
    console.log(`Corriendo en el puerto ${process.env.PORT}`);
});



