@isTest
private class ViewAllOpp_Test {
    
    public static testMethod void firstTest(){
        //creating Test Data
        Account acc=TestFactory.createAccount('1');
        insert acc;
        Account accObj=[Select Id, Name from Account where Id=:acc.Id limit 1];
        System.assert(acc.Id==accObj.Id,'Account Not inserted');
        Opportunity opp=TestFactory.getOpp(acc);
        insert opp;
        Opportunity oppObj=[Select Id, Name,account.Name,AccountId from Opportunity where Id=:opp.Id limit 1];
        System.debug('@@opp : '+opp);
        System.debug('@@oppObj : '+oppObj);
        System.assert(opp.Id==oppObj.Id,'Opportunity Not inserted');
        
        //validate code
        Id oppId=opp.Id;
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        ViewAllOpp op=new ViewAllOpp(sc);
        
        PageReference pageRef = Page.AccountOpps;
        pageRef.getParameters().put('id', String.valueOf(acc.Id));
        Test.setCurrentPage(pageRef);
        op.getRelatedOpps();
        op.IdValue=opp.Id;
        op.deleteOp();
        
        List<Opportunity> oppLst=[Select Id, Name,account.Name,AccountId from Opportunity where Id=:oppId];
        System.assert(oppLst.size()==0,'Opportunity not deleted');
        
    }
}