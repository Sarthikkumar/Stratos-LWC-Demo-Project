import { LightningElement, wire, api, track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContactList';
import getAccounts from '@salesforce/apex/ContactController.getAccountList';
import getOpportunities from '@salesforce/apex/ContactController.getOpportunityList';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import ID_FIELD from '@salesforce/schema/Contact.Id';

import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';
import OWNERID_FIELD from '@salesforce/schema/Opportunity.OwnerId';

const COLS = [
    {
        label: 'First Name',
        fieldName: FIRSTNAME_FIELD.fieldApiName,
        editable: true
    },
    {
        label: 'Last Name',
        fieldName: LASTNAME_FIELD.fieldApiName,
        editable: true
    },
    { label: 'Title', fieldName: TITLE_FIELD.fieldApiName, editable: true },
    {
        label: 'Phone',
        fieldName: PHONE_FIELD.fieldApiName,
        type: 'phone',
        editable: true
    },
    {
        label: 'Email',
        fieldName: EMAIL_FIELD.fieldApiName,
        type: 'email',
        editable: true
    }
];

const OppCols =[{
    label: 'Name',
    fieldName: NAME_FIELD.fieldApiName,
    editable: true
},
{
    label: 'Amount',
    fieldName: AMOUNT_FIELD.fieldApiName,
    editable: true
},
{
    label: 'Owner',
    fieldName: OWNERID_FIELD.fieldApiName,
    editable: false
}];
export default class Complex_Component extends LightningElement {
    @api recordId;
    @track mapData = [];
    @api selectedOption ='';
    columns = COLS;
    OppColumns = OppCols;
    draftValues = [];
    @track value='';

    @wire(getContacts, { accId: '$recordId' })
    contacts;

    @wire(getOpportunities, { accId: '$recordId' })
    opportunities;

    handleChange(event) {
        // Get the string of the "value" attribute on the selected option
        this.selectedOption = event.detail.value;
        this.recordId = event.detail.value ;
    }

    get options(){
        console.log('it came here');
        return this.mapData;
    }

    @wire(getAccounts)
    accounts({data,error}){
      this.mapData = [];
        if (data) { 
            // for(var i in data){
            //     //this.mapData = [...this.mapData, {label:data[i].Name, value:data[i].Id}];
            //    this.mapData.push({label:data[i].Name, value:data[i].Id});
            // }

            for(let i=0; i<data.length; i++)  {
                this.mapData = [...this.mapData ,{value: data[i].Id , label: data[i].Name} ];                                   
            }
    };
}


    async handleSave(event) {
        // Convert datatable draft values into record objects
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });

        // Clear all datatable draft values
        this.draftValues = [];

        try {
            // Update all records in parallel thanks to the UI API
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);

            // Report success with a toast
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contacts updated',
                    variant: 'success'
                })
            );

            // Display fresh data in the datatable
            await refreshApex(this.contacts);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading contacts',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
}