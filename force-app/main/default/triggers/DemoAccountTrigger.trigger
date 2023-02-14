trigger DemoAccountTrigger on Account (before insert) {
if(trigger.isBefore)
{
    if(trigger.isInsert)
    {
        Account acc = Trigger.New[0];
        acc.website = 'www.DynoTech.com';
        acc.Phone = '9839454523';
    }
}
}