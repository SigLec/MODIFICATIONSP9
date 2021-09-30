/**
 * Description this class is used to set up data we need for tests application
 */
@isTest
public class TestFactory {

    // Create a List of accounts
    public static List<Account> generateAccountsList(Integer numAccts) {
        List<Account> accounts = new List<Account>();
        for(Integer i=0; i<numAccts; i++) {
            Account account = new Account(Name='Account Test ' + i);
            accounts.add(account);
        }
        insert accounts;
        return accounts;
    }

    // Create a List of orders associated to an Account
    public static List<Order> generateOrdersForAccounts(List<Account> accounts, Integer numOrders, Integer UnitPrice, Integer quantity) {
        List<Order> orders = new List<Order>();
        for(Account account : accounts) {
        for(Integer j=0; j<numOrders; j++) {
            Order order = new Order(
                AccountId=account.Id,
                EffectiveDate=Date.today(),
                Status='Draft',
                Pricebook2Id=Test.getStandardPricebookId());
            orders.add(order);
            }
        }
        insert orders;

    Product2 product = new Product2(Name='Chemise Verte longue XYX', Family = 'Chemise');
    insert product;
        PricebookEntry pbe = new PricebookEntry(
            Product2Id = product.Id,
            Pricebook2Id = Test.getStandardPricebookId(),
            UnitPrice = UnitPrice,
            IsActive = true);
        insert pbe;
        List<OrderItem> orderItems = new List<OrderItem>();
        OrderItem orderItem;
        for(Order order : orders) {
            orderItem = new orderItem (
                OrderId = order.Id,
                UnitPrice = unitPrice,
                Quantity = quantity,
                PricebookEntryId = pbe.Id);
            orderItems.add(orderItem);
        }
        insert orderItems;
        return orders;
    }

    // Create users
    public static User generateUser(String fName, String lName) {
        User user = new User(
            ProfileId = [SELECT Id FROM Profile WHERE Name='Standard User' LIMIT 1].Id,
            LastName = lName,
            FirstName = fName,
            Email = fName + lName + '@sf.com',
            Alias = fName,
            Username = fName + lName + '@sf.com',
            TimeZoneSidKey = 'GMT',
            LanguageLocaleKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LocaleSidKey = 'en_US'
        );
        insert user;
        return user;
    }
}