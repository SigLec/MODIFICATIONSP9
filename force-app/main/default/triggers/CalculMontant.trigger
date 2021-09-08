trigger CalculMontant on Order (before insert, before update) {
	
	/*Modification à apporter : 
	Créer une boucle qui itère sur toutes les commandes et non la 1ère commande (index[0] comme ici) */
	List<Order> orderToUpdate = new List<Order>();
	for(Order ord : trigger.new) {
		//if(ord.ShipmentCost__c != null && )
		ord.NetAmount__c = ord.TotalAmount - ord.ShipmentCost__c;
		orderToUpdate.add(ord);
	}

	update orderToUpdate;
	//Order newOrder= trigger.new[0];
	//newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}