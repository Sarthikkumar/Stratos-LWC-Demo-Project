trigger AccountDemoTrigger on Account (before insert, after insert, after update, before delete) {
    
List<Messaging.SingleEmailMessage> mails =  new List<Messaging.SingleEmailMessage>();
List<String> sendTo = new List<String>();    
    
if(Trigger.isBefore)
{
    if(Trigger.isInsert)
    {
       List<Account> accList =  Trigger.New;
        
        for(Account acc : accList)
        {
            if(acc.BillingState =='CA')
            {
                acc.Description = 'Based in California';
            }
        }
    }
}
    
    if(Trigger.isAfter)
{
    if(Trigger.isInsert)
    {
        List<Account> accList =  Trigger.New;
        List<Project__c> proList = new List<Project__c>();
        
        for(Account acc : accList)
        {
            Project__c pro = new Project__c( Name= acc.Name + '- Project', Account__c = acc.Id );
            proList.add(pro);
            
            sendTo.add(acc.Email__c);
     
            if (acc.Email__c != null) {
                 
            Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
              
            mail.setToAddresses(sendTo);
            mail.setSubject('Welcome to Dyno Soft Tech');
            String body = 'Hi ' + acc.Name;
            mail.setHtmlBody(body);
            mails.add(mail);

        }    
        }
        
        Messaging.sendEmail(mails);
        insert proList;
        
        
    }
}
    
    if(Trigger.isAfter)
{
    if(Trigger.isUpdate)
    {
        List<Account> accList =  Trigger.New;
        List<Case> CaseList = new List<Case>();
      
        for(Account acc : accList)
        {
            if(acc.Active__c == 'No')
            {
                List<Case> tempList = [Select Id from Case WHERE AccountId =:acc.Id AND status='New'];
                CaseList.addAll(tempList);
            }
        }
        delete CaseList;
    }
}
    
    if(Trigger.isBefore)
{
    if(Trigger.isDelete)
    {
        List<Account> accList =  Trigger.old;
        
        for(Account acc : accList)
        {
            if(acc.Active__c == 'Yes')
            {
                acc.addError('Delete Operation Not Possible as Account is Active');
            }
        }
    }
}
    
}