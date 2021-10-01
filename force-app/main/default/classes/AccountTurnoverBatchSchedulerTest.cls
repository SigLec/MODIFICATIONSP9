@isTest
public with sharing class AccountTurnoverBatchSchedulerTest {

    @isTest static void testScheduledJob () {
        // CRON expression: midnight on March 15. In this test, job is supposed to execute immediately after Test.stopTest()
        String CRON_EXP = '0 0 0 15 3 ? 2022';
    
        // Check there is no asynchronous job in org 
        List<AsyncApexJob> enqueueJob = [SELECT Id, ApexClassID, ApexClass.Name, Status, JobType 
                                         FROM AsyncApexJob];
        System.assertEquals(0, enqueueJob.size());
    
        Test.startTest();
        // Schedule the the batch
        String jobId = System.schedule('testForBatch', CRON_EXP, new AccountTurnoverBatchScheduler());
        Test.stopTest();
    
        // Check schedulable is now in the AsyncApexJob list
        List<AsyncApexJob> scheduledJob = [SELECT Id, ApexClassID, ApexClass.Name, Status, JobType 
                                           FROM AsyncApexJob where JobType = 'ScheduledApex'];
        System.assertEquals(1, scheduledJob.size());
        System.assertEquals('AccountTurnoverBatchScheduler', scheduledJob[0].ApexClass.Name);
    
        // Check apex batch is now in the AsyncApexJob list
        List<AsyncApexJob> batchJob = [SELECT Id, ApexClassID, ApexClass.Name, Status, JobType 
                                       FROM AsyncApexJob where JobType = 'BatchApex'];
        System.assertEquals(1, batchJob.size());
        System.assertEquals('AccountTurnoverBatch', batchJob[0].ApexClass.Name);
    }
}

