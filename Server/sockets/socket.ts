import { Socket } from 'socket.io';
import { io } from '../index';
import { Banda } from '../models/banda';
import { Bands } from '../models/bands';

const bands = new Bands([]);

bands.addBand('Heroes del Silecion');
bands.addBand('Panteon Rococo');
bands.addBand('Metallica');
bands.addBand('Guns N Roses');

console.log(bands);

io.on("connect", (cliente: Socket) => {
  console.log("Cliente Conectado ");

  cliente.emit('bandas-server', bands.getBands());

  cliente.on('disconnect', () => {
    console.log("Cliente Desconnectado");
  });

  cliente.on('mensaje', (e: Banda) => {
    console.log(e);

    io.emit('respuesta', e);
  });


  cliente.on('nuevo-m', (payload) => {
    console.log(payload);
    // io.emit('nuevo-mensaje', payload); Todos
    cliente.broadcast.emit('nuevo-mensaje', payload);
  });

  cliente.on('vote-band', (payload:Banda) => {
    bands.voteBand(payload);
    io.emit('bandas-server', bands.getBands());
  });

  cliente.on('add-band',(payload: Banda) => {
    bands.addBand(payload.name);
    io.emit('bandas-server', bands.getBands());
  });

  cliente.on('delete-band', (payload:Banda)=>{
    bands.deleteBand(payload);
    io.emit('bandas-server', bands.getBands());
  });


  
});

