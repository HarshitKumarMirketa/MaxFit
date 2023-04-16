@isTest
private class EventManagerTest {

    @isTest
    static void getEventsTest(){

        Event_Organizer__c organizer = new Event_Organizer__c(
            Name = 'Harshit Kumar',
            Email__c = 'xyz@gmail.com'
        );

        insert organizer;

       Events__c event = new Events__c(
            Name__c = 'Test Event',
            Status__c = 'Created',
            Organizer__c = organizer.Id,
            Start__c = date.today(),
            End__c = date.today().addDays(5),
            Max_Seats__c = 100,
            Live__c = true,
            Event_type__c = 'Virtual'
       );

       insert event;

       Test.startTest();

       RestContext.response = new RestResponse();

       EventManager.getEvents();

       List<Object> results = (List<Object>) JSON.deserializeUntyped(RestContext.response.responseBody.toString());
       Map<string, object> resultDataMap = (Map<string, object>) results[0]; 
       Map<string,Object> eventDataMap = (Map<string,Object>) resultDataMap.get('event');

       System.assertEquals('Test Event', String.valueOf(eventDataMap.get('name')));

       Test.stopTest();
    }

    @isTest
    static void noEventTest() {

        Test.startTest();

        RestContext.response = new RestResponse();

        EventManager.getEvents();

        //System.assertEquals(null,RestContext.Response.ResponseBody);

        String expectedResponseBody = '[]'; // empty JSON array
        String actualResponseBody = RestContext.Response.ResponseBody.toString();
    
        System.assertEquals(expectedResponseBody, actualResponseBody);


        Test.stopTest();
        
        
    }   
}