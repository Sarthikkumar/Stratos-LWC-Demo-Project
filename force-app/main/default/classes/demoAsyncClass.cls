public class demoAsyncClass implements Database.Batchable<sObject>
{
    // Batch
    public List<Contact> start(Database.BatchableContext bc){
        String query = 'Select Id, Name , Account.Name from Contact';
        return Database.query(query);
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contactsList){
        for(Contact c : contactsList)
        {
            System.debug(c.Name + ' || ' + c.Account.Name);
        }
        
    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch Executed Successfully');
    }
}