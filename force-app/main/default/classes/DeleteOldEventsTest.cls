@isTest
public class DeleteOldEventsTest {
    @TestSetup
    static void setupTest(){
        List<Events__c> eventsToDelete = new List<Events__c>();
        for (Integer i = 0; i < 200; i++) {
            Events__c event = new Events__c();
            event.Name__c = 'Test Event ' + i;
            event.Start__c = Date.today().addMonths(-3);
            event.End__c = Date.today().addMonths(-3).addDays(3);
            event.Live__c = true;
            eventsToDelete.add(event);
        }

            Events__c event = new Events__c();
            event.Name__c = 'Test Event x';
            event.Start__c = Date.today().addMonths(3);
            event.End__c = Date.today().addMonths(3).addDays(3);
            event.Live__c = true;
            eventsToDelete.add(event);

        insert eventsToDelete;
    }

    @isTest
    static void eventDeleteBatchTestMethod() {
        Test.startTest();
        DeleteOldEvents batch1 = new DeleteOldEvents();
        Database.executeBatch(batch1);
        Test.stopTest();

        List<Events__c> deletedEventsRecord = [Select Id,Name__c from Events__c];

        System.assertEquals(0, deletedEventsRecord.size(),'All events record which are occur two months before should delete');
    }

}