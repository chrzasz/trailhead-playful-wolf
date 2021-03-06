global class LeadProcessor implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT ID FROM Lead'
        );
    }

    global void execute(Database.BatchableContext bc, List<Lead> records){
        // process each batch of records
        List<Lead> leads = new List<Lead>();
        for (Lead l : records) {
            l.LeadSource = 'Dreamforce';
            leads.add(l);
        }
        update leads;
    }    

    global void finish(Database.BatchableContext bc){
        // execute any post-processing operations
        System.debug('records processed. Shazam!');
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :bc.getJobId()];
    }    
}
