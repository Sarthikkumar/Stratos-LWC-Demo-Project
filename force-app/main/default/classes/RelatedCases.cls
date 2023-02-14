public with sharing class RelatedCases {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCaseList(String accId) {
        return [
            SELECT CaseNumber, Subject
            FROM Case
            where AccountId=:accId];
    }
}
