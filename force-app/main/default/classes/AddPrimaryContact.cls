public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String state;

    public AddPrimaryContact(Contact contact, String state) {
        this.contact = contact;
        this.state = state;
    }

    public void execute(QueueableContext context) {
        List<Account> accounts = [
            SELECT Id, Name, (SELECT Id, FirstName, LastName FROM Contacts)
            FROM Account
            WHERE BillingState = :state LIMIT 200
            ];
        List<Contact> contacts = new List<Contact>();
        for(Account a : accounts) {
            Contact c = contact.clone(false,false,false,false);
            c.AccountId = a.Id;
            contacts.add(c);
        }
        if(!contacts.isEmpty()) {
            insert contacts;
        }


    }
}