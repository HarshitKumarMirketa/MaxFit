@RestResource(urlMapping='/Speaker/*')
global with sharing class SpeakerManager {
    @HttpPost
    global static String createSpeaker(String Name,String Email,String Phone,String Company) {
        Speaker__c speaker = new Speaker__c(
            Name = Name,
            Email__c = Email,
            Phone__c = Phone,
            Company__c = Company
        );

        try {
            RestResponse res = RestContext.response;
            insert speaker;
            res.statusCode = 200;
            return 'Insertion Successful';

        } catch (Exception e) {
            RestResponse res = RestContext.response;
            res.statusCode = 400;
            return 'Insertion Failed';
            
        }
    }
}