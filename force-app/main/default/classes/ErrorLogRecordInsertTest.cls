@isTest private class ErrorLogRecordInsertTest {
    
    @isTest
    static void insertErrorLogTest() {

        String logDetails = 'Testing logDetails';
        String processName = 'Testing processName';

        Test.startTest();
        ErrorLogRecordInsert.insertErrorLog(logDetails,processName);
        Test.stopTest();

        List<Error_Log__c> log  = [Select Id,Log__c,Log_Details__c,Process_Name__c from Error_Log__c];

        System.assertEquals(logDetails,log[0].Log_Details__c);
        System.assertEquals(processName,log[0].Process_Name__c);

    }
    
}