/**
 * Calculation of net amount before updating
 */
trigger UpdateNetAmount on Order (before update) {
    for(Order order : Trigger.New) {
        order.NetAmount__c = order.TotalAmount - order.ShipmentCost__c;
    }
}

	