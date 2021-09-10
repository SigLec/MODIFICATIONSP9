public with sharing class AccountUtility {
    public AccountUtility() {       
    }
    // Query to select accounts with related orders
    public static List<Account> selectAcctsWithOrders() {
        List<Account> acctsWithOrders = [SELECT Name FROM Account WHERE Id IN (SELECT AccountId FROM Order)];
    }

    // Query to select accounts with related actiaved orders -- Use for Batch --
    public static List<Account> selectAcctsWithActivatedOrders() {
        String batchQuery = [SELECT Id, Name, Chiffre_d_affaire__c 
                             FROM Account
                             WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Activated')];
        return batchQuery;
    }
}

