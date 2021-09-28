public with sharing class AccountUtility {
  
	// Create a method that will update AccountTurnover when related orders are activated : 
    public static void calculTurnover(List<Account> acctsWithOrders) {
        // For each activated order, update the turnover of the associated accounts : 
        for(Account account : acctsWithOrders) {
            account.Turnover__c = 0;
            for(Order order : account.Orders) {
            account.Turnover__c += order.TotalAmount;
            }                               
        }
        update acctsWithOrders;
    }
}