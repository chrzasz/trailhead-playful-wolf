@isTest
private class AddPrimaryContactTest {
    // insert 50 Account records for BillingState "NY"
    // and 50 Account records for BillingState "CA"
    // Create an instance of the AddPrimaryContact class,
    // enqueue the job and assert that a Contact record was inserted
    // for each of the 50 Accounts with the BillingState of "CA".

    @testSetup 
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i=0;i<50;i++) {
            accounts.add(new Account(Name='Name'+i, BillingState = 'NY'));
        }
        for (Integer i=0;i<50;i++) {
            accounts.add(new Account(Name='Name'+i, BillingState = 'CA'));
        }
        insert accounts;
    }

    @isTest
    static void testQueueJob() {
         // query for test data to pass to queueable class
        List<Account> accounts = [SELECT Id, Name From Account];

        Contact contact = new Contact(
            FirstName = 'Test',
            LastName = 'Test'
        );
        insert contact;

        // Create our Queueable instance
        AddPrimaryContact apc = new AddPrimaryContact(contact, 'CA');
        Test.startTest();
            System.enqueueJob(apc);
        Test.stopTest();
        System.assertEquals(50, [SELECT count() FROM Contact WHERE AccountID IN (SELECT id FROM Account WHERE BillingState = 'CA')]);
    }
}