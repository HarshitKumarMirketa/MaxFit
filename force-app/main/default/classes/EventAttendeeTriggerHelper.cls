public class EventAttendeeTriggerHelper {

    public static void sendConfirmationMail(List<Event_Attendee__c> attendees){

        Set<Id> attendeeIdSet = new Set<Id>();
        Set<Id> eventIdSet = new Set<Id>();

        for(Event_Attendee__c ea : attendees){
            AttendeeIdSet.add(ea.Attendees__c);
            EventIdSet.add(ea.Events__c);
        }

        Map<Id, Attendees__c> attendeeMap = new Map<Id, Attendees__c>([SELECT Id, Name, Email__c From Attendees__c WHERE  Id IN : attendeeIdSet]);
        Map<Id, Events__c> eventMap = new Map<Id, Events__c>([SELECT Id, Name__c, Start__c, Location__r.Name, Organizer__r.Name From Events__c WHERE  Id IN : eventIdSet]);

        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();

        for(Event_Attendee__c attendee : attendees){

            Attendees__c Att = attendeeMap.get(attendee.Attendees__c);
            Events__c Eve = eventMap.get(attendee.Events__c);

            String subject = 'Pass For The '+Eve.Name__c;
            String body = 'Dear '+Att.Name+',\n\n';

            body+='Thank you for registering for '+Eve.Name__c+' which will be Organized on '+Eve.Start__c+' at '+Eve.Location__r.Name+' We are excited to have you, see you at the event.\n\n';
            

            body += 'Thanks,\n' +Eve.Organizer__r.Name;

            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new String[]{Att.Email__c});
            email.setSubject(subject);
            email.setPlainTextBody(body);
            emails.add(email);
        }

        List<Messaging.SendEmailResult> results = Messaging.sendEmail(emails, false);
        for(Messaging.SendEmailResult email : results){
            System.debug(email.isSuccess());
        }
    }

}