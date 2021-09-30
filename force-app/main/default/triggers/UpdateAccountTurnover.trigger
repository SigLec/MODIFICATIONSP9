/**
 * @description trigger used to update account turnover each time related orders are updated on 'Ordered' status
 */
trigger UpdateAccountTurnover on Order (after update) {

    // Get account list with Ordered orders
    Set<Id> acctIdSet = new Set<Id>();
    for(Order order : trigger.new) {
        if(order.Status == 'Ordered') {
            acctIdSet.add(order.AccountId);
        }
    }
    // Update CA from those accounts
    List<Account> acctsWithOrders = QueryService.getAcctsWithOrders(acctIdSet);
    AccountUtility.calculTurnover(acctsWithOrders);
}