public class ViewAllOpp {
    
    public Account accObj{get; set;}
    public string billingAddress{get; set;}
    public List<Opportunity> oppList{get; set;}
    public string IdValue{get; set;}
    public Map<Id,Opportunity> oppMap{get; set;}
    
    public ViewAllOpp(ApexPages.StandardController std){
        accObj=(Account)std.getRecord();
        Id accountId=accObj.Id;
        System.debug('@@accountId : '+accountId);
        List<Account> accLst=[SELECT Id, Name,AccountNumber, Owner.Name, BillingCity, BillingCountry, BillingState, BillingPostalCode, BillingStreet, Phone, AnnualRevenue FROM Account where Id=:accountId];
        System.debug('@@accountId : '+accountId);
        if(accLst.size()>0){
            accObj=accLst[0];
            billingAddress=accObj.BillingStreet+','+accObj.BillingCity+','+ accObj.BillingState+','+accObj.BillingCountry+','+ accObj.BillingPostalCode;
        	System.debug('@@accObj : '+accObj);
            getRelatedOpps();
        }
    }
    
    public PageReference deleteOp(){
        System.debug(IdValue);
        System.debug('@@Map : '+oppMap);
        if(oppMap.containsKey(IdValue)){
            delete oppMap.get(IdValue);
            getRelatedOpps();
        }
       return null; 
    }
    
    public void getRelatedOpps(){
        oppMap=new Map<Id,Opportunity>();
        oppList=[SELECT Id, Name, Amount, Type, StageName,AccountId FROM Opportunity where AccountId=:accObj.Id];
        for(Opportunity o : oppList){
            oppMap.put(o.id,o);
        }
        System.debug('@@oppMap : '+oppMap);
        System.debug('@@oppMap : '+oppMap.values());
        oppList=oppMap.values(); 
    }

}