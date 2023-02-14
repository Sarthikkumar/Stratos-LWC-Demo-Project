import { LightningElement, wire , track , api } from 'lwc';

import getAccounts from '@salesforce/apex/ContactController.getAccountList';

export default class C2PChild extends LightningElement {

    @api recordId;
    @track mapData = [];
    @api selectedOption ='';
    @track value='';

    handleChange(event) {
        this.selectedOption = event.detail.value;
        this.recordId = event.detail.value ;
        this.value = event.detail.value ;
        this.dispatchEvent(new CustomEvent("accountchange",
        { detail: this.value }
        ));
    }

    @wire(getAccounts)
    accounts({data,error}){
      this.mapData = [];
        if (data) { 

            for(let i=0; i<data.length; i++)  {
                this.mapData = [...this.mapData ,{value: data[i].Id , label: data[i].Name} ];                                   
            }
    };
}
}