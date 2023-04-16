public class EventOrganizerController {
    public Event_Organizer__c eventOrganizer { get; set; }
    public Location_Address_Book__c eventLocation { get; set; }
    public Events__c event  { get; set; }


    public EventOrganizerController() {
        eventOrganizer = new Event_Organizer__c();
        eventLocation = new Location_Address_Book__c();
        event = new Events__c();
    }


    public void Save() {
        Savepoint sp = Database.setSavepoint();
        try {
            insert eventLocation;
            insert eventOrganizer;

            event.Organizer__c = eventOrganizer.Id;
            if(event.Event_Type__c != 'Virtual') {
                event.Location__c = eventLocation.Id;
            }
            
            insert event;
        }
        catch(Exception e) {
            Database.rollback(sp);
            ErrorLogRecordInsert.insertErrorLog(e.getMessage(), 'Error Message');            
        }

    }

}