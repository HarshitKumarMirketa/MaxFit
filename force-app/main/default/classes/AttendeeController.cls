public class AttendeeController {

    public Attendees__c attendee{get;set;}
    public Event_Attendee__c eventAttendee{get;set;}
    public Location_Address_Book__c location{get;set;}

    public AttendeeController() {
        attendee = new Attendees__c();
        eventAttendee = new Event_Attendee__c();
        location = new Location_Address_Book__c();

        Id currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        if(currentRecordId != null) {
            eventAttendee.Events__c = currentRecordId;
        }
    }

    public void Save() {
        Savepoint sp = Database.setSavepoint();
        try {
            insert location;
            attendee.Address__c = location.Id;
            insert attendee;
            eventAttendee.Attendees__c = attendee.Id;
            insert eventAttendee;
        }
        catch(Exception e) {
            Database.rollback(sp);
            ErrorLogRecordInsert.insertErrorLog(e.getMessage(), 'Error Message');
        }
        finally {
            attendee = new Attendees__c();
            eventAttendee = new Event_Attendee__c();
            location = new Location_Address_Book__c();
        }
    }
}