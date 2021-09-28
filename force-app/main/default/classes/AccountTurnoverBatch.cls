global class AccountTurnoverBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext info){
        // Select totalAmount from accounts with activated orders
        String queryForBatch = QueryService.getAccountsToUpdateInBtach();
        return Database.getQueryLocator(queryForBatch);
    }
    global void execute(Database.BatchableContext info, List<Account> acctsWithOrders){
        AccountUtility.calculTurnover(acctsWithOrders);
    }

    global void finish(Database.BatchableContext info){
    }
}
