trigger UpdateAccountCA on Order (after insert, after update, after delete, after undelete) {
	// trigger now activated when an order is inserted, updates, deleted or undeleted

    set<Id> setAccountIds = new set<Id>();
    
    for(integer i=0; i< trigger.new.size(); i++){
        Order newOrder= trigger.new[i];
       
        // Query modifications to have only activated Orders 
        Account acc = [SELECT Id, Chiffre_d_affaire__c,(SELECT Status FROM Orders WHERE Status='Activated')
                       FROM Account 
                       WHERE Id =:newOrder.AccountId];

        /* Bug detected : error message when we are creating a new order. If the chiffre_d_affaire field is
        empty or equal to 0, we can't crate a new order.
        Add a if/else block to fix the code */   
        if(acc.Chiffre_d_affaire__c != null || acc.Chiffre_d_affaire__c != null) {
            acc.Chiffre_d_affaire__c = acc.Chiffre_d_affaire__c + newOrder.TotalAmount;
        } else {
            acc.Chiffre_d_affaire__c = newOrder.TotalAmount;
        }
        update acc;
    }
}