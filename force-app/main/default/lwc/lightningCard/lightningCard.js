import { LightningElement , api } from 'lwc';

export default class LightningCard extends LightningElement {

    @api textValue = "";

    handleInputChange(event){
        this.textValue = event.detail.value.toUpperCase();
    }
}