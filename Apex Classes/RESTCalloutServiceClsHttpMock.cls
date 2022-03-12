/*
* Application Name:- Custom code calculator
* Created:- 12/03/2022
* Last Updated:- 12/03/2022
* Description:- This is mock call to test the callout.
*/
@isTest
global class RESTCalloutServiceClsHttpMock implements HttpCalloutMock {
    private static final String RESPONSE_BODY = '{"output":"Test Output"}';
    private static final Integer RESPONSE_SUCCESS = 200;
     // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody(RESPONSE_BODY);
        response.setStatusCode(RESPONSE_SUCCESS);
        
        return response;
    }
}
