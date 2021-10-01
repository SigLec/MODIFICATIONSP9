@isTest
private class MyTeamOrdersControllerTest {
    @TestSetup
    static void setUp() {
        Integer numAccts = 1;
        Integer numOrders = 3;
        Integer unitPrice = 8;
        Integer quantity = 6;
        //Use TestFactory Data
        List<Account> testAccounts = TestFactory.generateAccountsList(numAccts);
        List<Order> testOrders = TestFactory.generateOrdersForAccounts(testAccounts, numOrders, unitPrice, quantity);
        for (Order order : testOrders) {
            order.Status = 'Ordered';
        }
        update testOrders;
        
        User u1 = TestFactory.generateUser('Paul', 'BOLI');
        User u2 = TestFactory.generateUser('Pierre', 'LOPARE');

        System.runAs(u1) {
        TestFactory.generateOrdersForAccounts(testAccounts, numOrders, unitPrice, quantity);
        }
        System.runAs(u2) {
        TestFactory.generateOrdersForAccounts(testAccounts, numOrders, unitPrice, quantity);
        }
    }
    
    @isTest
    static void testCalculSumByOwner() {
        Test.startTest();
        MyTeamOrdersController mtoc = new MyTeamOrdersController();
        List <AggregateResult> expectedResults = mtoc.aggregate;
        Test.stopTest();
        System.assert(expectedResults.size()>0);
    }
}
