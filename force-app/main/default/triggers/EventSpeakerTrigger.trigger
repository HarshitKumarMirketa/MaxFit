trigger EventSpeakerTrigger on Event_Speaker__c (before insert) {
    EventSpeakerTriggerHelper.checkDuplicateSpeaker(trigger.new);
}