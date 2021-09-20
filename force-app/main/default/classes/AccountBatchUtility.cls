global with sharing class AccountBatchUtility {
    // Create a method that will update AccountTurnover__c when order is activated
    global static void calculCAForBatch(List<Account> acctsWithOrders) {             
        for(Account acct : acctsWithOrders) {
            acct.Turnover__c = 0;
            for(Order o : acct.Orders) {
                acct.Turnover__c += o.TotalAmount;
            }                 
        }
        update acctsWithOrders;
    }
}
