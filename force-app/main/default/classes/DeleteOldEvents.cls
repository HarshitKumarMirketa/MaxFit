public class DeleteOldEvents implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'SELECT Id,End__c,Live__c FROM Events__c WHERE End__c < LAST_N_MONTHS:2 AND Live__c = true';
        return Database.getQueryLocator(query);
    }
        
    public void execute(Database.BatchableContext BC, List<Events__c> listRecords) {
        delete listRecords;
    }
        
    public void finish( Database.BatchableContext bc ) {
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    mail.setToAddresses(new String[] {'harshit.kumar@mirketa.com'});
    mail.setSubject('Execution of the batch has been processed');
    mail.setPlainTextBody('Batch for deleting 2 months old has been processed');
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
 }
}