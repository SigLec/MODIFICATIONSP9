public with sharing class QueryService {
    
    // Query to find accounts with orders
    public static List<Account> getAcctsWithOrders(Set<Id> acctIdSet) {
        List<Account> acctsWithOrders = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status='Activated')
                                         FROM Account 
                                         WHERE Id IN : AcctIdSet];
        return acctsWithOrders;
    }

    public static String getAccountsToUpdateInBtach() {
        String queryForBatch = 'SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')';
        return queryForBatch;
    }
}
