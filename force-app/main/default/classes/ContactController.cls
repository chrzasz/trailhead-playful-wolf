public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact() {
        return [
            SELECT Id, Name, Phone, MobilePhone, Email, PhotoUrl
            FROM Contact
            LIMIT 1
        ];
    }
}