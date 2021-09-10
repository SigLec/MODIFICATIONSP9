global class UpdateAccountCaBatch implements Database.Batchable<sObject>{
    // The batch job starts
    global Database.QueryLocator start(Database.BatchableContext info){ 
        // Add query from AccountUtility class as parameter
        String batchQuery = AccountUtility.selectAcctsWithActivatedOrders();
        return Database.batchQuery();
    }
     
    // The batch job executes and operates on one batch of records
    global void execute(Database.BatchableContext info, List<Account> scope){      
        // Ajouter ici la formule de calcul CA
        list<Order> listOrders =  [SELECT Id, TotalAmount, AccountId FROM Order];        
         for(integer i=0; i < scope.size(); i++){
             Account myAccount = scope[i];
             myAccount.Chiffre_d_affaire__c = 0;
            for(integer j=0; j < listOrders.size(); j++){
                if(listOrders[j].AccountId == myAccount.Id){
                    myAccount.Chiffre_d_affaire__c = myAccount.Chiffre_d_affaire__c + listOrders[j].TotalAmount;
                }                   
            }
        }
        update scope;
    }    
    // The batch job finishes
    global void finish(Database.BatchableContext info){     
        
    } 
    /* CODE DE UpdateAllAccounts
    global void execute(Database.BatchableContext info, List<Account> scope){
        
        Set<Id> setAccountIds = (new Map<Id,SObject>(scope)).keySet();
        AP01Account.updateChiffreAffaire(setAccountIds);
    } */    
 }