@isTest
private class EventAttendeeTriggerTest {
    @isTest
    static void AttendeeEmailHandlerTest() {

        Event_Organizer__c newEventOrg = new Event_Organizer__c();
        newEventOrg.Name = 'Deepanshu';
        insert newEventOrg;

        Location_Address_Book__c newLocation = new 	Location_Address_Book__c();
        newLocation.Name = 'Lucknow';
        insert newLocation;

        Events__c newEvent = new Events__c();
        newEvent.Name__c = 'Singing';
        newEvent.Organizer__c = newEventOrg.Id;
        newEvent.Location__c = newLocation.Id;
        newEvent.Start__c = Datetime.now();
        newEvent.End__c = Datetime.now().addDays(3);
        newEvent.Live__c = true;
        newEvent.Event_Type__c = 'In-Person';
        newEvent.Frequency__c = 'Weekly';
        newEvent.Max_Seats__c = 100;
        newEvent.Recurring__c = true;
        insert newEvent;

        Attendees__c newAttendee = new Attendees__c();
        newAttendee.Name = 'Harshit Kumar';
        newAttendee.Email__c = 'harshit.kumar@mirketa.com';
        newAttendee.Phone__c = '7054089231';
        insert newAttendee;

        Event_Attendee__c newEventAttendee = new Event_Attendee__c();
        newEventAttendee.Attendees__c = newAttendee.Id;
        newEventAttendee.Events__c = newEvent.Id;
        insert newEventAttendee;

        List<Event_Attendee__c> eventAttendeeList = [Select Id ,Attendees__c,Events__c from Event_Attendee__c where Id =: newEventAttendee.Id];

        Test.StartTest();
        AttendeeEmailHandler.sendConfirmationMail(eventAttendeeList);
        Test.StopTest();

        Integer invoice=Limits.getEmailInvocations();
        System.assertEquals(1, invoice,'Email sent');

    }
}