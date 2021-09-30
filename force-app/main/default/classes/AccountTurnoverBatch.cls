/**
 * @description This batch class is used to update account turnover each week to take into account new prices
 */



global class AccountTurnoverBatch implements Database.Batchable<sObject> {
    //The batch job starts
    global Database.QueryLocator start(Database.BatchableContext info){
        // Select totalAmount from accounts with ordered orders
        String queryForBatch = QueryService.getAccountsToUpdateInBtach();
        return Database.getQueryLocator(queryForBatch);
    }
    //The batch job executes and operates on one batch of records
    global void execute(Database.BatchableContext info, List<Account> acctsWithOrders){
        AccountUtility.calculTurnover(acctsWithOrders);
    }
    // The batch job finishes
    global void finish(Database.BatchableContext info){
    }
}
