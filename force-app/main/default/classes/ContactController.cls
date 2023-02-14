public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactList(String accId) {
        return [
            SELECT
                Id,
                Name,
                FirstName,
                LastName,
                Title,
                Phone,
                Email
            FROM Contact
            where AccountId=:accId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList() {
        return [
            SELECT
                Id,
                Name
            FROM Account
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpportunityList(String accId) {
        return [
            SELECT
                Id,
                Name,
                Amount,
                OwnerId
            FROM Opportunity
            where AccountId=:accId];
    }

    @AuraEnabled(cacheable=true)
    public static List<Contact> findContacts(String searchKey) {
        String key = '%' + searchKey + '%';
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            WHERE Name LIKE :key
            LIMIT 10
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Contact getSingleContact() {
        return [
            SELECT Id, Name, Title, Phone, Email
            FROM Contact
            LIMIT 1
        ];
    }

    @AuraEnabled
    public static void updateContacts(List<Contact> contactsForUpdate) {
        // Make sure we can update the database before trying to update
        if (!Schema.sObjectType.Contact.isUpdateable()) {
            throw new SecurityException(
                'Insufficient permissions to update contacts'
            );
        }
        update contactsForUpdate;
    }
}