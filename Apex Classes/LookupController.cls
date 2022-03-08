public with sharing class LookupController {
    
    //This method finds the record

    @AuraEnabled(cacheable=true)

    public static List<sObject> findRecords(String searchKey, String objectName, String filterField){
        String query = '';

        if(filterField != null && filterField != ''){
            query = 'Select Id, Name from ' + String.escapeSingleQuotes(objectName) + ' Where Name Like  \'%' + String.escapeSingleQuotes(searchKey) + '%\' AND ' + String.escapeSingleQuotes(filterField) + ' AND NamespacePrefix=\'\' LIMIT  10';
        }
        else{
            if(searchKey == null || searchKey == ''){
                query = 'Select Id, Name from ' + String.escapeSingleQuotes(objectName) + ' Where NamespacePrefix=\'\' LIMIT  10';
            }
            else {
                query = 'Select Id, Name from ' + String.escapeSingleQuotes(objectName) + ' Where Name Like  \'%' + String.escapeSingleQuotes(searchKey) + '%\' AND NamespacePrefix=\'\' LIMIT  10';
            }
        }
        system.debug('Query: ' + query);
        List<sObject> recordList = database.query( query );

        return recordList;
    }
}
