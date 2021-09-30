/**
 * @description Utility class to store turnover calculation used in other classes
 */
public with sharing class AccountUtility {
  
	// Method that will update AccountTurnover when related orders are Ordered : 
    public static void calculTurnover(List<Account> acctsWithOrders) {
        // For each Ordered order, update the turnover of the associated accounts : 
        for(Account account : acctsWithOrders) {
            account.Turnover__c = 0;
            for(Order order : account.Orders) {
            account.Turnover__c += order.TotalAmount;
            }                               
        }
        update acctsWithOrders;
    }
}