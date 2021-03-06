@isTest
private class UpdateAccountTurnoverTest {
    @isTest static void testUpdateTurnoverFor105Orders() {
        Integer numAccts = 10;
        Integer numOrders = 105;
        Integer UnitPrice = 10;
        Integer quantity = 5;
        //Use TestFactory Data
        List<Account> testAccounts = TestFactory.generateAccountsList(numAccts);
        List<Order> testOrders = TestFactory.generateOrdersForAccounts(testAccounts, numOrders, UnitPrice, quantity);
        for (Order order : testOrders) {
            order.Status = 'Ordered';
        }

        Test.startTest();
        update testOrders;
        Test.stopTest();
        
        testAccounts = [SELECT Id, Turnover__c
                            FROM Account
                            WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Ordered')
                        ];
        System.assertEquals(numAccts, testAccounts.size());
        Integer expectedCA = numOrders * UnitPrice * quantity;
        for(Account account : testAccounts){
            System.assertEquals(expectedCA, account.Turnover__c);
        }
    }

    @isTest static void testUpdateTurnoverFor201Orders() {
        Integer numAccts = 1;
        Integer numOrders = 201;
        Integer UnitPrice = 10;
        Integer quantity = 5;
        List<Account> testAccounts = TestFactory.generateAccountsList(numAccts);
        List<Order> testOrders = TestFactory.generateOrdersForAccounts(testAccounts, numOrders, UnitPrice, quantity);
        for (Order order : testOrders) {
            order.Status = 'Ordered';
        }

        Test.startTest();
        update testOrders;
        Test.stopTest();
        
        testAccounts = [SELECT Id, Turnover__c
                            FROM Account
                            WHERE Id IN (SELECT AccountId FROM Order WHERE Status='Ordered')
                        ];
        System.assertEquals(numAccts, testAccounts.size());
        Integer expectedCA = numOrders * UnitPrice * quantity;
        for(Account account : testAccounts){
            System.assertEquals(expectedCA, account.Turnover__c);
        }
    }

}
