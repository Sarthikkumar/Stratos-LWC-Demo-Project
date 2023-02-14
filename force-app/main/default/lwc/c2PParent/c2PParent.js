import { LightningElement , api, wire} from 'lwc';
import getCaseList from '@salesforce/apex/RelatedCases.getCaseList';
import NUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import SUBJECT_FIELD from '@salesforce/schema/Case.Subject';

const cols =[{
    label: 'Case Number',
    fieldName: NUMBER_FIELD.fieldApiName,
    editable: false
},
{
    label: 'Subject',
    fieldName: SUBJECT_FIELD.fieldApiName,
    editable: false
}
];

export default class C2PParent extends LightningElement {

    @api accId= "0015g00000sBFZqAAO";
    columns = cols;

    handleAccountChange(event)
    {
        this.accId = event.detail;
    }

    @wire(getCaseList, { accId : '$accId'}) cases;

}