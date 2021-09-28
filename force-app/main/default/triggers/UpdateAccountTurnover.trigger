trigger UpdateAccountTurnover on Order (after update) {

    // Get account list with activated orders
    Set<Id> acctIdSet = new Set<Id>();
    for(Order order : trigger.new) {
        if(order.Status == 'Activated') {
            acctIdSet.add(order.AccountId);
        }
    }
    // Update CA from those accounts
    List<Account> acctsWithOrders = QueryService.getAcctsWithOrders(acctIdSet);
    AccountUtility.calculTurnover(acctsWithOrders);
}