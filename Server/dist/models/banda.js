"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Banda = void 0;
const uuid_1 = require("uuid");
class Banda {
    constructor(name = 'no-name', id = (0, uuid_1.v4)(), votes = 0) {
        this.name = name;
        this.id = id;
        this.votes = votes;
    }
}
exports.Banda = Banda;
