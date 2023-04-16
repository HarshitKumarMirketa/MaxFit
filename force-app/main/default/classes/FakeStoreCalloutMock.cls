@isTest
Private class FakeStoreCalloutMock {
    @isTest static  void testGetCallout() {

      Test.setMock(HttpCalloutMock.class, new FakeStoreHttpCalloutMock());
        
        HttpResponse res = CreateProductRecord.createRecord();
        
        //System.debug(res);
        

        String contentType = res.getHeader('Content-Type');
        System.assert(contentType == 'application/json');

        System.assertEquals(200, res.getStatusCode(), 'successful authentication');

        Product2 product = [SELECT Id, Name FROM Product2 WHERE Name = 'Super Fast Car'];
        System.assertEquals(product.Name, 'Super Fast Car');

        Pricebook2 pricebook = [SELECT Id, Name FROM Pricebook2 WHERE Name = 'Harshit-pricebook'];
        System.assertEquals(pricebook.Name, 'pushkarraja-pricebook');

        // Id stdPricebook = Test.getStandardPricebookId();

        // List<PricebookEntry> standardEntry = [SELECT Id FROM PricebookEntry WHERE Pricebook2Id =: pricebook.Id AND Product2Id =: stdPricebook];

        // System.assertEquals(standardEntry.size(), 1);

        List<PricebookEntry> customEntry = [SELECT Id FROM PricebookEntry WHERE Pricebook2Id =: pricebook.Id AND Product2Id =: product.Id];
        System.assertEquals(customEntry.size(),1);


    }
}