public with sharing class QueryService {
    
    // Query to find accounts with Ordered orders
    public static List<Account> getAcctsWithOrders(Set<Id> acctIdSet) {
        List<Account> acctsWithOrders = [SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status='Ordered')
                                         FROM Account 
                                         WHERE Id IN : AcctIdSet];
        return acctsWithOrders;
    }
    
    public static String getAccountsToUpdateInBtach() {
        String queryForBatch = 'SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status=\'Ordered\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Ordered\')';
        return queryForBatch;
    }
}
