@isTest
private class DailyLeadProcessorTest {
/*
In the test class, insert 200 Lead records, schedule the DailyLeadProcessor class
to run and test that all Lead records were updated correctly.
*/
// Dummy CRON expression: midnight on March 15.
// Because this is a test, job executes
// immediately after Test.stopTest().
public static String CRON_EXP = '0 0 0 15 3 ? 2022';

@testSetup 
static void setup() {
    List<Lead> leads = new List<Lead>();
    for (Integer i=0;i<200;i++) {
        leads.add(new Lead(Lastname='Name'+i, Company='company'+i));
    }
    insert leads;
}

@isTest
static void testScheduledJob() {
    System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = NULL], '200 leads not available for test');        
    Test.startTest();
    // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest', CRON_EXP, new DailyLeadProcessor());
        // Verify the scheduled job has not run yet.
        List<Lead> leadsBeforeUpdate = [SELECT Id, LeadSource FROM Lead];
        for (Lead l : leadsBeforeUpdate) {
            System.assert(l.LeadSource == NULL, 'Leads updated before job has run!');
        }
        // Stopping the test will run the job synchronously
    Test.stopTest();
    // Now that the scheduled job has executed,
    // check that our leads were updated
    System.assertEquals(200, [SELECT count() FROM Lead WHERE LeadSource = 'Dreamforce'], 'Leads not updated by job!');
}
}
