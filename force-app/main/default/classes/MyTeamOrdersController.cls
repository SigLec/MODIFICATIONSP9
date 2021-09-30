/**
 * @description class to display the total amount of orders by commercial
 */
public with sharing class MyTeamOrdersController {

    // Query that return orders amount by commercial 
    public List <AggregateResult> aggregate {get;set;} 

    public MyTeamOrdersController() {
        aggregate = new List<AggregateResult>();
        aggregate = [SELECT SUM(TotalAmount) tAmount, owner.Name oName 
                  FROM Order 
                  WHERE Status='Ordered'
                  GROUP BY owner.Name ORDER BY SUM(TotalAmount) DESC];
        }
}