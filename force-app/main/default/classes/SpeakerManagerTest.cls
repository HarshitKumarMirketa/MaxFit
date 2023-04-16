@isTest
private class SpeakerManagerTest {
    // @isTest
    // static void test1(){

    //     Test.startTest();

    //         RestContext.request = new RestRequest();
    //         RestContext.response = new RestResponse();

    //         String respo = CreateSpeakerService.createSpeaker('Ferocious chipmunk', 'chipmunk@gmail.com', '9992987895');
    //         Speaker_c speaker = [SELECT Id, Name, Phonec FROM Speaker_c WHERE Name = 'Ferocious chipmunk'];

    //         System.assertEquals('Ferocious chipmunk', speaker.Name);
    //         System.assertEquals(200, RestContext.response.statusCode);
            

    //     Test.stopTest();
    // }

    @isTest
    static void test2(){

        Test.startTest();

            RestContext.request = new RestRequest();
            RestContext.response = new RestResponse();

            String respo = SpeakerManager.createSpeaker('Ferocious chipmunk', 'chipmunk@gmail.com', '9992987895','Mirketa');
            String respo2 = SpeakerManager.createSpeaker('Ferocious chipmunk', 'chipmunk@gmail.com', '9992987895','Mirketa');
            List<Speaker__c> speaker = [SELECT Id, Name, Phone__c FROM Speaker__c WHERE Name = 'Ferocious chipmunk'];

            System.assertEquals(1, speaker.size());
            System.assertEquals(400, RestContext.response.statusCode);
            

        Test.stopTest();
    }

}