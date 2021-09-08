public without sharing class MyTeamOrdersController {

    // Query that return orders amount by commercial 
    public decimal OdersAmountByCommercial {
        get{
			AggregateResult groupedResults = [SELECT SUM(TotalAmount) total, 
                                              Owner.Name owner  
                                              FROM Order 
                                              WHERE Status='Activated'
                                              GROUP BY Owner.Name];
			return (decimal)groupedResults.get('total');
        }
        set;
    }
}
