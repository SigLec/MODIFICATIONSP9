@isTest
private class AccountTurnoverBatchTest {
    @TestSetup
    static void generateData(){
        Integer numAccts = 10;
        Integer numOrders = 120;
        Integer UnitPrice = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestFactory.generateAccountsList(numAccts);
        List<Order> testOrders = TestFactory.generateOrdersForAccounts(testAccounts, numOrders, UnitPrice, quantity);
        for (Order order : testOrders) {
            order.Status = 'Activated';
        }
        update testOrders;
    }

    // Calculation turnover test
    @isTest static void test_whenBatchExecutedWith10Accounts_shouldReturnUpdatedTurnover() {
        Test.startTest();
        AccountTurnoverBatch atb = new AccountTurnoverBatch();
        Id batchId = DataBase.executeBatch(atb); 
        Test.stopTest();

        List<Account> results = [SELECT Id, Turnover__c
                                    FROM Account
                                    WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Activated')];

        System.assertEquals(10, results.size());
        for(Account account : results){
            System.assertEquals(120 * 5 * 10, account.Turnover__c);
        }
    }
}
