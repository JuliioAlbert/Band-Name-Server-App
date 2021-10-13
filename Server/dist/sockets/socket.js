"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const index_1 = require("../index");
const bands_1 = require("../models/bands");
const bands = new bands_1.Bands([]);
bands.addBand('Heroes del Silecion');
bands.addBand('Panteon Rococo');
bands.addBand('Metallica');
bands.addBand('Guns N Roses');
console.log(bands);
index_1.io.on("connect", (cliente) => {
    console.log("Cliente Conectado ");
    cliente.emit('bandas-server', bands.getBands());
    cliente.on('disconnect', () => {
        console.log("Cliente Desconnectado");
    });
    cliente.on('mensaje', (e) => {
        console.log(e);
        index_1.io.emit('respuesta', e);
    });
    cliente.on('nuevo-m', (payload) => {
        console.log(payload);
        // io.emit('nuevo-mensaje', payload); Todos
        cliente.broadcast.emit('nuevo-mensaje', payload);
    });
    cliente.on('vote-band', (payload) => {
        bands.voteBand(payload);
        index_1.io.emit('bandas-server', bands.getBands());
    });
    cliente.on('add-band', (payload) => {
        bands.addBand(payload.name);
        index_1.io.emit('bandas-server', bands.getBands());
    });
    cliente.on('delete-band', (payload) => {
        bands.deleteBand(payload);
        index_1.io.emit('bandas-server', bands.getBands());
    });
});
