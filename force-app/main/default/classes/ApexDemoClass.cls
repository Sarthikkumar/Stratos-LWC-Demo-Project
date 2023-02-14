public class ApexDemoClass {
public Integer Sum(Integer a, Integer b)
{
   return a+b;    
}
public String FullName(String a, String b)
{
    return (a+' '+b);
}
public Account CreateAccount(String InputName)
{
    Account acc = new Account(Name = InputName);
    insert acc;
    return acc;
}
public Contact createContact(Id accId, String InputLastName, String InputFirstName){
    Contact con = new Contact(AccountId = accId , LastName = InputLastName , FirstName = InputFirstName );
    insert con;
    return con;
}
public List<Contact> ListofContacts(Id accId){
    // List<Contact> conList = [Select Name, (Select LastName, Firstname, AccountId from Contacts) from Account where Id=:accId];
    List<Contact> conList = [Select Id,LastName, Firstname, AccountId from Contact where AccountId=:accId];
    return conList;
}
public void AccountAndContact(Integer noOfContacts , Id accId){
    Integer i;
    List<Contact> conList = new List<Contact>();
    for(i=0; i<noOfContacts; i++)
    {
        Contact con = new Contact(AccountId = accId , LastName='Contact'+i, FirstName='New');
        conList.add(con);
    }
    insert conList;
}
}