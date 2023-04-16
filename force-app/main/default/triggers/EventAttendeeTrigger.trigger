trigger EventAttendeeTrigger on Event_Attendee__c (after insert) {
    EventAttendeeTriggerHelper.sendConfirmationMail(Trigger.new);
}