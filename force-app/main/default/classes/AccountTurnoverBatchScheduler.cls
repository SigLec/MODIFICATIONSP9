global with sharing class AccountTurnoverBatchScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        AccountTurnoverBatch batchable = new AccountTurnoverBatch();
        Id batchId = Database.executeBatch(batchable);
    }
}
