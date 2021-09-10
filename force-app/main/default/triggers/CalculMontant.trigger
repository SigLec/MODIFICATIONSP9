trigger CalculMontant on Order (before update) {
	// Mettre la requête dans une autre classe et l'appeler ensuite
	
	List<Order> orderToUpdate = new List<Order>();
	for(Order ord : trigger.new) {
		if(ord.ShipmentCost__c != null) {
		ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
		orderToUpdate.add(ord);
		} else {
		ord.NetAmount__c = ord.TotalAmount;
		orderToUpdate.add(ord);
		}
		}
	insert orderToUpdate;
	}
	//Order newOrder= trigger.new[0];
	//newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
