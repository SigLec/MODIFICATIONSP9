trigger CalculMontant on Order (before update) {
	
	/*Modification à apporter : 
	Créer une boucle qui itère sur toutes les commandes et non la 1ère commande (index[0] comme ici) */
	
	Order newOrder= trigger.new[0];
	newOrder.NetAmount__c = newOrder.TotalAmount - newOrder.ShipmentCost__c;
}