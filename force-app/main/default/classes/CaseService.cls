public with sharing class CaseService {
    
    public static List<Case> getAllCases() {
        //lookup filter is on Case->ContactId: 'Contact Name: Account Name IDEQUALSCase: Account Name ID'
        List<Case> allCases = [
            SELECT
                Id,
                ContactId, 
                CaseNumber,
                AccountId,
                Reason,
                IsEscalated,
                Priority,
                Product__c,
                SLAViolation__c,
                Status,
                Subject,
                Type
            FROM Case
        ];
        return allCases;
    }
}