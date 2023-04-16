public class SpeakerController {

    public Speaker__c speaker{get;set;}
    public Event_Speaker__c eventSpeaker{get;set;}

    public SpeakerController() {
        speaker = new Speaker__c();
        eventSpeaker = new Event_Speaker__c();

        Id currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        if(currentRecordId != null) {
            eventSpeaker.Events__c = currentRecordId;
        }

    }

    public void Save() {
        Savepoint sp = Database.setSavepoint();
        try {
            insert speaker;
            eventSpeaker.Speaker__c = speaker.Id;
            insert eventSpeaker;
        }
        catch(Exception e) {
            Database.rollback(sp);
            ErrorLogRecordInsert.insertErrorLog(e.getMessage(), 'Error Message');
        }
    }
}