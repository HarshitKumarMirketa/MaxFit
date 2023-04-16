public  class CreateProductRecord {
    public static HttpResponse createRecord() {

        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://fakestoreapi.com/products');
        req.setMethod('GET');

        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() == 200) {
            String response = res.getBody();
            
            List<Object> productList = (List<Object>) JSON.deserializeUntyped(response);

	        List<Product2> productDetailList = new List<Product2>();
            List<PricebookEntry> pbEntryList = new List<PricebookEntry>();
            List<PricebookEntry> pbEntryList2 = new List<PricebookEntry>();

            Pricebook2 standardPB = new Pricebook2();

            if(Test.isRunningTest()){
                id pbid = Test.getStandardPricebookId();
                standardPB.id = pbid;
             } else {
				standardPB = [select id from Pricebook2 where isStandard = true];
             }

            Pricebook2 pb = new Pricebook2(Name = 'Harshit-pricebook', Description = 'Price Book', IsActive = true);
            insert pb;

            //Pricebook2 standardPB = [select id from Pricebook2 where isStandard = true];

            for (Object product : productList) {
                Map<String, Object> productMap = (Map<String, Object>) product;
                

                String title = (String) JSON.serialize(productMap.get('title'));
                title = title.substring(1, title.length() - 1);
                
                String descript = (String) JSON.serialize(productMap.get('description'));
                descript = descript.substring(1, descript.length() - 1);


                Product2 pro = new Product2(
                    ProductCode = (String) JSON.serialize(productMap.get('id')),
                    Name = title,
                    Description = descript
                );

                productDetailList.add(pro);
            }

            insert productDetailList;

            for (integer i = 0; i < productList.size(); i++) {
                Object product = productList.get(i);
                Id productId = productDetailList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));

                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = standardPB.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );

                pbEntryList.add(entry);
            }
            
			insert pbEntryList;

            for (integer i = 0; i < productList.size(); i++) {
                Object product = productList.get(i);
                Id productId = productDetailList.get(i).Id;

                Map<String, Object> productMap = (Map<String, Object>) product;

                Decimal strToDec = decimal.valueOf(JSON.serialize(productMap.get('price')));
                
                PricebookEntry entry = new PricebookEntry(
                    Pricebook2Id = pb.Id,
                    Product2Id = productId,
                    UnitPrice = strToDec,
                    IsActive = true
                );

                pbEntryList2.add(entry);
            }
            
            insert pbEntryList2;
            
        }

        return res;

    }
}