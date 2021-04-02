import { LightningElement, wire } from 'lwc';
import { getSObjectValue } from '@salesforce/apex';
import getSingleContact from '@salesforce/apex/ContactController.getSingleContact';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.MobilePhone';


export default class BikeCard extends LightningElement {

   description = 'A sweet bike built for comfort.';
   category = 'Mountain';
   material = 'Steel';
   price = '$2,700';
   pictureUrl = 'https://s3-us-west-1.amazonaws.com/sfdc-demo/ebikes/electrax4.jpg';

   @wire(getSingleContact) contact;

   get name() {
      return this.contact.data ? getSObjectValue(this.contact.data, NAME_FIELD) : '';
   }
   get email() {
      return this.contact.data ? getSObjectValue(this.contact.data, EMAIL_FIELD) : '';
   }
   get phone() {
      return this.contact.data ? getSObjectValue(this.contact.data, PHONE_FIELD) : '';
   }



}