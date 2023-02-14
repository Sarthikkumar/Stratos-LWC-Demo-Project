import { LightningElement , api} from 'lwc';

export default class Simple_Component extends LightningElement {

    @api textValue='';
    
    handleClick(event) {
        alert('Button Clicked');
    }

    get options() {
        return [
            { label: 'Mumbai', value: 'Mumbai' },
            { label: 'Bangalore', value: 'Bangalore' },
            { label: 'Noida', value: 'Noida' },
        ];
    }

    handleChange(event) {
        alert('Selected City is ' + event.detail.value);
    }
    handleInputChange(event){
        this.textValue = event.detail.value.toUpperCase();
    }

}