global class DailyLeadProcessor implements Schedulable {

    //The execute method must find the first 200 Leads with a blank LeadSource field
    // and update them with the LeadSource value of 'Dreamforce'.
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [
            SELECT Id, LeadSource 
            FROM Lead 
            WHERE LeadSource = null LIMIT 200];

        if (!leads.isEmpty()) {
            for(Lead l : leads) {
                l.LeadSource = 'Dreamforce';
            }    
        }
        update leads;
    }
}