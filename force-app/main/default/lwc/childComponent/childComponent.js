import { LightningElement , api, track , wire} from 'lwc';
import getAccounts from '@salesforce/apex/ChildAccountController.getAccountList';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';
import ACCOWNER_FIELD from '@salesforce/schema/Account.Owner.Name';

const cols =[{
    label: 'Name',
    fieldName: NAME_FIELD.fieldApiName,
    editable: false
},
{
    label: 'Phone',
    fieldName: PHONE_FIELD.fieldApiName,
    editable: false
},
{
    label: 'Website',
    fieldName: WEBSITE_FIELD.fieldApiName,
    editable: false
},
{
    label: 'Account Owner',
    fieldName: ACCOWNER_FIELD.fieldApiName,
    editable: false
}
];

export default class ChildComponent extends LightningElement {
    @api activeStatus= "No";
    columns = cols;

    @wire(getAccounts, { activeStatus : '$activeStatus'}) accounts;
        
    }
