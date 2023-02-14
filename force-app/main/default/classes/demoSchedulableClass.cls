global class demoSchedulableClass implements Schedulable {
global void execute(SchedulableContext sc){
        List<Project__c> projectList = [SELECT Id, Account__r.Name, Opportunity__r.Name, Project_Revenue__c, Project_Duration__c, Name FROM Project__c];
        for(Project__c Project : projectList)
        {
            System.debug(Project.Name + ' || ' + Project.Account__r.Name + ' || '+ Project.Opportunity__r.Name);
        }
    }
}