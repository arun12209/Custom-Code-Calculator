public with sharing class CustomCodeCalculatorController {
    
    @AuraEnabled(cacheable=true)
    public static Integer getApexLengthWithoutComments(String selectedApexRecordId,String apexType){

        Integer length = 0 ;
        List<ApexClass> apexClassList = new List<ApexClass>();
        List<ApexTrigger> apexTriggerList = new List<ApexTrigger>();

        String column = 'LengthWithoutComments';
        String condition = 'Id =: selectedApexRecordId';
        String query = 'select ' + String.escapeSingleQuotes(column) + ' from ' + String.escapeSingleQuotes(apexType) + ' where '+ String.escapeSingleQuotes(condition) ;
       
        List<sObject> recordList = database.query( query );

        if(apexType =='ApexClass'){
            apexClassList.add((ApexClass) recordList[0]);
            length = apexClassList[0].LengthWithoutComments;
        }else{
            apexTriggerList.add((ApexTrigger) recordList[0]);
            length = apexTriggerList[0].LengthWithoutComments;
        }

        return length;
    }
    
    /**
     * @description getApexDetails from destination org
     * @return String
     */
    @AuraEnabled(cacheable=true)
    public static String getApexDetails(String apexRecordId, String apexType){
        try {

            RESTCalloutServiceCls service = new RESTCalloutServiceCls('Production_Org');
            String query = 'SELECT+name,LengthWithoutComments+from+' + apexType + '+Where+ID=\'' + apexRecordId +  '\'';

            system.debug('Get Request: ' + service.getRequest());
            service.setURLParameter('q',query);

            system.debug('Get Request 1: ' + service.getRequest());
            HttpResponse res = service.sendRequest();

            return res.getBody();

        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
     * @description getApexType method used to get the Apex type custom metadata (e. ApexClass, ApexTrigger)
     * @return Map<String,Apex_Type__mdt>
     */
    @AuraEnabled(cacheable=true)
    public static Map<String,Apex_Type__mdt> getApexType() {
        try{
            return Apex_Type__mdt.getAll();
        } 
        catch (Exception e) { throw new AuraHandledException(e.getMessage()); }
    }
}
