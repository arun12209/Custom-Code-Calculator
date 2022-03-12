/*
* Application Name:- Custom code calculator
* Created:- 02/03/2022
* Last Updated:- 02/03/2022
* Description:- This class used to test the custom lookup functionality
*/
@isTest 
public class LookupControllerTest {
	
    @isTest
    public static void testFindRecords(){
        //List<ApexClass> apexList = [Select id,Name,NamespacePrefix from ApexClass limit 10];
        Test.startTest();
            LookupController.findRecords('Opportunity', 'ApexClass','');
            LookupController.findRecords('', 'ApexClass','');
        Test.stopTest();
        
    }
}
