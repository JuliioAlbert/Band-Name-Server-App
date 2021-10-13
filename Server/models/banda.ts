
import {v4} from 'uuid';


export class Banda {
    constructor(
        public name:string = 'no-name', 
        public  id:string = v4(), 
        public votes:number= 0){}

    
}