"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Bands = void 0;
const banda_1 = require("./banda");
class Bands {
    constructor(bands) {
        this.bands = bands;
    }
    addBand(name) {
        this.bands.push(new banda_1.Banda(name));
    }
    getBands() {
        return this.bands;
    }
    deleteBand(banda) {
        this.bands = this.bands.filter(e => e.id != banda.id);
        return this.bands;
    }
    voteBand(banda) {
        this.bands = this.bands.map(e => {
            if (e.id == banda.id) {
                e.votes++;
                return e;
            }
            return e;
        });
    }
}
exports.Bands = Bands;
