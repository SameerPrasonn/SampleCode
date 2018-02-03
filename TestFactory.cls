@isTest
public class TestFactory {
    
    public static Account createAccount(String id){
        return new Account(Name='TestAcount'+id);
    }
    
    public static Opportunity getOpp(Account acc){
		String strDate=String.valueOf(System.now());
		strDate=strDate.replace('-','').replace(':','').replace(' ','');
        decimal amt=Math.random()*1500;
        //Developer Note : 
        //added discount percentage since in my dev org i have created extra fields,
        //which are related to some trailhead assingments and it is mark as required
        return new Opportunity(Name='TestOpp'+strDate,AccountId=acc.Id,closeDate=DateTime.now().date().addDays(90),Amount=amt,stageName='Prospecting',Discount_Percent__c=10);
    }

}