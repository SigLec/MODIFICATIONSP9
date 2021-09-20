global class AccountTurnoverBatch implements Database.Batchable<sObject> {

    global Database.QueryLocator start(Database.BatchableContext info){
        return Database.getQueryLocator('SELECT Id, (SELECT TotalAmount FROM Orders WHERE Status=\'Activated\') FROM Account WHERE Id IN (SELECT AccountId FROM Order WHERE Status=\'Activated\')');
    }
    global void execute(Database.BatchableContext info, List<Account> accountsWithOrders){
        AccountBatchUtility.calculCAForBatch(accountsWithOrders);
    }

    global void finish(Database.BatchableContext info){
    }
}
