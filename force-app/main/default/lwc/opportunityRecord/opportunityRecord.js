import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Opportunity.Name';
import TYPE_FIELD from '@salesforce/schema/Opportunity.Type';
import AMOUNT_FIELD from '@salesforce/schema/Opportunity.Amount';

export default class OpportunityRecord extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    fields=[NAME_FIELD, TYPE_FIELD, AMOUNT_FIELD];
}