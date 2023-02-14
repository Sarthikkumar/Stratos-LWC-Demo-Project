public with sharing class ChildAccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(String activeStatus) {
        return [
            SELECT Name, Phone, Website, Owner.Name
            FROM Account
            where Active__c =:activeStatus];
    }
}
