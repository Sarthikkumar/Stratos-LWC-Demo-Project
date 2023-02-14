public class demoQueueableClass implements Queueable { 
    public void execute(QueueableContext qc){
        List<Opportunity> oppList = [Select Name, Account.Name from Opportunity];
        for(Opportunity opp : oppList)
        {
            System.debug(opp.Name + ' || ' + opp.Account.Name);
        }
    }
}