@RestResource(urlMapping='/Events/*')
global with sharing class EventManager {

    public class EventWrapper {
        public String name;
        public Datetime date_time;
        public Integer max_attendee;

        public void set(string name,datetime date_time,Integer max_attendee) {
            this.name = name;
            this.date_time = date_time;
            this.max_attendee = max_attendee;
        }
    }

    public class EventOrganizerWrapper {
        public String name;
        public String email;

        public void set(string name,string email) {
            this.name = name;
            this.email = email;
        }
    }


    public static Map<String,Object> jsonMapMaking(object eventObject, object eventOrganizerObject) {
        Map<String,Object> jsonMap = new Map<String,Object>();
        jsonMap.put('event_organizer', eventOrganizerObject);
        jsonMap.put('event', eventObject);
        return jsonMap;
    }



    @HttpGet
    global static void getEvents() {

        RestContext.response.addHeader('Content-Type', 'application/json,charset-UTF-8');
        Integer totalEvents = [Select count() from Events__c];
        List<Object> eventDataList = new List<Object>();

        if(totalEvents <= 50000) {

            List<Events__c> result =  [SELECT Id,Name__c,Start__c,End__c,Max_Seats__c,Organizer__r.Name,Organizer__r.Email__c FROM Events__c];


           

            for(Events__c eventDetail : result) {
                EventWrapper eventObject = new EventWrapper();
                EventOrganizerWrapper eventOrganizerObject = new EventOrganizerWrapper();
                eventObject.set(eventDetail.Name__c,eventDetail.Start__c,(Integer)eventDetail.Max_Seats__c);
                eventOrganizerObject.set(eventDetail.Organizer__r.Name,eventDetail.Organizer__r.Email__c);

                //eventDataList.add(eventObject);
                //eventDataList.add(eventOrganizerObject);

                eventDataList.add(EventManager.jsonMapMaking(eventObject,eventOrganizerObject));
            }

            RestContext.response.responseBody = Blob.valueOf(JSON.serialize(eventDataList));
        }
        else {
            ErrorLogRecordInsert.insertErrorLog('Object has more than 50K Records','Web Service to get all the events');
        }
    }
}