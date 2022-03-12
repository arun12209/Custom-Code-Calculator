/*
* Application Name:- Custom code calculator
* Created:- 02/03/2022
* Last Updated:- 02/03/2022
* Description:- This class is the test class for CustomCodeCalculatorController class.
*/
@isTest
public class CustomCodeCalculatorControllerTest {
    private static final String CUSTOM_METADATA_NAME = 'TestMetadataRec';
 	private static final String APEX_OBJECT = 'ApexClass';
    private static final String APEX_TRIGGER_OBJECT = 'ApexTrigger';
    private static final String ENDPOINT = 'https://www.sfdclesson.com';
    private static final String METHOD = 'GET';
    private static final String BODY = '{"output":"Test Output"}';
    private static final String URL_PARAM = 'Key1';
    
    @isTest
    public static void testCustomCodeCalculator(){
        List<ApexClass> apexClsList = [Select Id from ApexClass limit 1];
        List<ApexTrigger> apexTrgList = [Select Id from ApexTrigger limit 1];
        List<Apex_Type__mdt> apexType = [Select Label from Apex_Type__mdt];
        
        Test.startTest();
        
        CustomCodeCalculatorController.getApexLengthWithoutComments(apexClsList[0].Id, APEX_OBJECT);
        CustomCodeCalculatorController.getApexLengthWithoutComments(apexTrgList[0].Id, APEX_TRIGGER_OBJECT);
        Map<String,Apex_Type__mdt> apexTypeMap = CustomCodeCalculatorController.getApexType();
		system.assertEquals(2, apexTypeMap.size());
        
        Test.stopTest();
    }
    @isTest
    public static void testGetApexDetailsCallout(){
        
        List<ApexClass> apexClsList = [Select Id from ApexClass limit 1];
        
        Test.startTest();
        RESTCalloutServiceCls service = new RESTCalloutServiceCls(CUSTOM_METADATA_NAME);
        
        service.setEndpointURL(ENDPOINT);
        service.getEndpointURL();
        
        service.setRequestMethod(METHOD);
        service.getRequestMethod();
        
        service.setRequestBody(BODY);
        service.getRequestBody();
        
        service.getURLParam(URL_PARAM);
        service.getURLParamMap();
        
        Test.setMock(HttpCalloutMock.class, new RESTCalloutServiceClsHttpMock());
        
        CustomCodeCalculatorController.getApexDetails(apexClsList[0].Id, APEX_OBJECT);
        
        system.assertEquals(ENDPOINT, service.getEndpointURL());
        Test.stopTest();
    }
}
