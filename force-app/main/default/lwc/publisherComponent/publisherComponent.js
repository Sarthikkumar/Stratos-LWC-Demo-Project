import { LightningElement, api , wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNT_UPDATED_CHANNEL from '@salesforce/messageChannel/PubSub__c';

export default class PublisherComponent extends LightningElement {
 
 @api message='';

 @wire(MessageContext)
  messageContext;

  handleInputChange(event) {
    // this.counter++;
    this.message = event.detail.value;
  }

  sendMessage()
  {
    const payload = { 
        message: this.message
      };
      publish(this.messageContext, COUNT_UPDATED_CHANNEL, payload);
  }
}