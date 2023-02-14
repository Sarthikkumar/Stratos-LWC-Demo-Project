import { LightningElement, api, track, wire } from 'lwc';
import {unsubscribe, subscribe, MessageContext } from 'lightning/messageService';
import MESSAGE_FROM_CHANNEL from '@salesforce/messageChannel/PubSub__c';

export default class SubscriberComponent extends LightningElement {

    @track messages = [];
    @api subscription = null;
    @api subscribed = false;
    
    @wire(MessageContext) messageContext;

    subscribeToMessageChannel() {
        if(this.subscription)
        {
            console.log("hello");
        }

        if(this.subscription == null)
        {
        this.subscription = subscribe(
        this.messageContext,
        MESSAGE_FROM_CHANNEL,
        (message) => this.handleMessage(message)
        );
        this.subscribed = true;
        }
    }

    handleMessage(message) {

    this.messages = [...this.messages, JSON.stringify(message, null, " ")];

    }
    connectedCallback() {
      this.subscribeToMessageChannel();
    }

    unSubscribeToMessageChannel(){

        unsubscribe(this.subscription);
        this.subscription = null;
        this.subscribed = false;
    }

  }
