@isTest
private class UpdateNetAmountTest {
    @isTest 
    static void testUpdateNetAmountWhenMoreThanOneOrderUpdated() {
        Integer numAccts = 1;
        Integer numOrders = 15;
        Integer UnitPrice = 10;
        Integer quantity = 5;
        //Use TestFactory Data
        List<Account> testAccounts = TestFactory.generateAccountsList(numAccts);
        List<Order> testOrders = TestFactory.generateOrdersForAccounts(testAccounts, numOrders, UnitPrice, quantity);
        for (Order order : testOrders) {
            order.ShipmentCost__c = 3;
        }

        Test.startTest();
        update testOrders;
        Test.stopTest();

        testOrders = [SELECT NetAmount__c FROM Order];
        Integer exepectedNetAmount = 10 * 5 - 3;
        for(Order order : testOrders) {
            System.assertEquals(exepectedNetAmount, order.NetAmount__c);
            }
        }
}
