import { Banda } from './banda';


export class Bands {
    
    constructor(public bands:Banda[] ){
    }


    addBand(name: string){
        this.bands.push(new Banda(name))    
    }


    getBands(): Banda[]{
        return this.bands;
    }

    deleteBand(banda:Banda){
        this.bands= this.bands.filter(e => e.id != banda.id);
        return this.bands;
    }


    voteBand(banda:Banda){
        this.bands = this.bands.map(e => {
            if(e.id == banda.id){
                e.votes++;
                return e;
            }return e;
        } );
    }


}