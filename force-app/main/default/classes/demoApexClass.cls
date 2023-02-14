public class demoApexClass {
    public List<Contact> demoSOQLMethod(){
        List<Contact> soqlResult = [Select Name, Account.Name from Contact LIMIT 30];
        return soqlResult;
    }
    public List<List<sObject>> demoSOSLMethod(){
        List<List<sObject>> soslResult = [FIND 'Bravo*' IN ALL FIELDS RETURNING Account(Name), Contact(Name), Opportunity(Name)];
        return soslResult;
    }
    public void DMLmethods(String Name, string phone, string website, string action, string accId){
        
        Account acc = new Account(Name=Name, Phone = phone, Website=website);
        if(action == 'insert')
        {
            insert acc;
        }
        if(action == 'update')
        {
            acc.Id = accId;
            acc.name = 'Updated name';
            update acc;
        }
        
        if(action == 'delete')
        {
            acc.Id = accId;
            delete acc;
        }
        
        
    }
}