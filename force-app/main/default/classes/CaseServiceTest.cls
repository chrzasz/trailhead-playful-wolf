@isTest
private class CaseServiceTest {

    @isTest
    static void caseServiceTest_withContactAssociatedWithAccount_caseCreated() {
        
        Account acc1 = new Account();
        acc1.Name = 'Test Acme 1';
        Account acc2 = new Account();
        acc2.Name = 'Test Acme 2';
        List<Account> accountToInsert = new List<Account>();
        accountToInsert.add(acc1);
        accountToInsert.add(acc2);
        insert accountToInsert;
        List<Account> fetchAccounts = [SELECT Id FROM Account];
        System.assert(fetchAccounts.size() == 2);
        Contact cont1acc1 = new Contact();
        cont1acc1.LastName = 'Test Contact 1';
        cont1acc1.AccountId = fetchAccounts.get(0).Id;
        Contact cont2acc1 = new Contact();
        cont2acc1.LastName = 'Test Contact 2';
        cont2acc1.AccountId = fetchAccounts.get(0).Id;
        List<Contact> contactsToInsert = new List<Contact>();
        contactsToInsert.add(cont1acc1);
        contactsToInsert.add(cont2acc1);
        insert contactsToInsert;
        List<Contact> fetchContacts = [SELECT Id FROM Contact];
        System.assert(fetchContacts.size() == 2);

        Test.startTest();
            Case newCase1Acc1Contact1 = new Case();
            newCase1Acc1Contact1.Status = 'New';
            newCase1Acc1Contact1.Origin = 'Phone';
            newCase1Acc1Contact1.Priority = 'Medium';
            newCase1Acc1Contact1.AccountId = fetchAccounts.get(0).Id;
            newCase1Acc1Contact1.ContactId = fetchContacts.get(0).Id;
            insert newCase1Acc1Contact1;
        Test.stopTest();

        List<Case> fetchCases = [SELECT Id FROM Case];
        System.assert(fetchCases.size() == 1);
    }


    @isTest
    static void caseServiceTest_withContactNotAssociatedWithAccount_caseNotCreated() {
        
        Account acc1 = new Account();
        acc1.Name = 'Test Acme 1';
        Account acc2 = new Account();
        acc2.Name = 'Test Acme 2';
        List<Account> accountToInsert = new List<Account>();
        accountToInsert.add(acc1);
        accountToInsert.add(acc2);
        insert accountToInsert;
        List<Account> fetchAccounts = [SELECT Id FROM Account];
        System.assert(fetchAccounts.size() == 2);
        Contact cont1acc1 = new Contact();
        cont1acc1.LastName = 'Test Contact 1';
        cont1acc1.AccountId = fetchAccounts.get(0).Id;
        Contact cont2acc1 = new Contact();
        cont2acc1.LastName = 'Test Contact 2';
        cont2acc1.AccountId = fetchAccounts.get(0).Id;
        List<Contact> contactsToInsert = new List<Contact>();
        contactsToInsert.add(cont1acc1);
        contactsToInsert.add(cont2acc1);
        insert contactsToInsert;
        List<Contact> fetchContacts = [SELECT Id FROM Contact];
        System.assert(fetchContacts.size() == 2);

        Test.startTest();
            Case newCase1Acc1Contact1 = new Case();
            newCase1Acc1Contact1.Status = 'New';
            newCase1Acc1Contact1.Origin = 'Phone';
            newCase1Acc1Contact1.Priority = 'Medium';
            newCase1Acc1Contact1.AccountId = fetchAccounts.get(1).Id;
            newCase1Acc1Contact1.ContactId = fetchContacts.get(0).Id;
            try {
                insert newCase1Acc1Contact1;
            } catch (DmlException e) {
                System.assert( e.getMessage().contains('first error: FIELD_FILTER_VALIDATION_EXCEPTION, Value does not exist or does not match filter criteria.: [ContactId]'),
                e.getMessage() );
            }
        Test.stopTest();

        List<Case> fetchCases = [SELECT Id FROM Case];
        System.assert(fetchCases.size() == 0);
    }
}
