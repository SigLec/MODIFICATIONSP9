public with sharing class AccountUtility {
  
	// Create a method that will update AccountTurnover when related orders are activated : 
    public static void updateAccountTurnover(List<Order> ordersFromTrigger) {
        
        // Create a set to store account id associated to orders
        Set<Id> AcctIdSet = new Set<Id>();
        for(Order currentOrder : ordersFromTrigger) {
            AcctIdSet.add(currentOrder.AccountId);
        }

        // Create a list to select accounts to update (accounts with related orders) :
        List<Account> acctsToUpdate = [SELECT Id, Turnover__c
                                       FROM Account 
                                       WHERE Id IN : AcctIdSet];
       
        // For each activated order, update the turnover of the associated accounts : 
        for(Order currentOrder : ordersFromTrigger) {
            if(currentOrder.Status=='Activated') {
                for(Account acct : acctsToUpdate) {
                    acct.Turnover__c += currentOrder.TotalAmount;
                    update acctsToUpdate;
                }                 
            }
        }
    }
}