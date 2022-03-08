/*
* Application Name:- Custom code calculator
* Created:- 01/03/2022
* Last Updated:- 01/03/2022
* Description:- This class used to make the Http callout

*/
public with sharing class RESTCalloutServiceCls {

    REST_callout_configuration__mdt calloutConfig;
    String endpointURL, requestMethod, requestBody;
    Integer requestTimeout;

    Map<String, String> urlParamsMap; //URL parameters map

    static final String TYPE_URL_PARAMETERS = 'URL_PARAMETERS';
    

    HTTPRequest req; //Http rquest

    /**
     * gettter and setter methods
     */
    public String getEndpointURL() {
		return endpointURL;
	}

    //set endpoint url
	public void setEndpointURL(String endpointURL) {
		this.endpointURL = endpointURL;
	}

    //get request method
    public String getRequestMethod() {
		return requestMethod;
	}

    //set request method
	public void setRequestMethod(String reqMethod) {
		this.requestMethod = requestMethod;
	}

    //get request body
	public String getRequestBody() {
		return requestBody;
	}

    //set request body
	public void setRequestBody(String reqBody) {
		this.requestBody = requestBody;
	}

    

    //get the url parameters
    public String getURLParam(String key) {
        return urlParamsMap.get(key);
    }

    //get the url param map
    public Map<String, String> getURLParamMap() {
        return urlParamsMap;
    }

    //add the element in the urlParamsMap 
    public void setURLParameter(String mapKey, String mapValue) {

        if(String.isNotEmpty(mapKey) && String.isNotEmpty(mapValue)) {

            urlParamsMap.put(mapKey, mapValue);

        } 
        else if(String.isNotEmpty(mapKey)) {

            urlParamsMap.put(mapKey, mapValue);

        }
        
    }

    //remove the element from map based on map key
    public void removeURLParameter(String key) {
        urlParamsMap.remove(key);
    }


    //constructor without parameter
    public RESTCalloutServiceCls() {
        initializeVariables();
    }

    //initialize variables

    private void initializeVariables() {

        urlParamsMap = new Map<String, String>();

        if(calloutConfig != null) {

            endpointURL = calloutConfig.Endpoint_URL__c;
            requestMethod = calloutConfig.Method__c;
            

            setUrlParameters(TYPE_URL_PARAMETERS, calloutConfig.URL_parameters__c);
            
        }
    }

    //this method used to set the url parameters
    private void setUrlParameters(String paramType, String paramInfo) {
        if(String.isNotEmpty(paramInfo)) {

            Map<String, String> parametersMap = new Map<String, String>();

            List<String> parameters = paramInfo.split('\n');

            for(String urlParam : parameters) {

                List<String> keyValuePair = urlParam.trim().split(':');

                if(!keyValuePair.isEmpty()) {

                    if(keyValuePair.size() == 2) {
                        if(String.isNotEmpty(keyValuePair[0]) && String.isNotEmpty(keyValuePair[1])) {

                            parametersMap.put(keyValuePair[0], keyValuePair[1]);

                        }
                    } 
                    
                }
            }
            
           urlParamsMap.putAll(parametersMap);
            
        }
    }
    //*********************************end**************************** */

    //parameterized constructor
    public RESTCalloutServiceCls(String mdtConfigName) { //mdtConfigName (Custom metadata type name)
        try {

            calloutConfig = REST_callout_configuration__mdt.getInstance( mdtConfigName);

        } 
        catch (Exception e) {

            system.debug('Exception has occured! '+e.getMessage());

        }

        initializeVariables();
    }

    //append the parameters to the endpoint url
    private void appendParametersToURL() {

        Set<String> urlParamMapKeys = urlParamsMap.keySet();

        if(!urlParamMapKeys.isEmpty()) {

            endpointURL += '?';
            for(String urlParamKey : urlParamMapKeys) {
                endpointURL += urlParamKey + '=' + urlParamsMap.get(urlParamKey) + '&';
            }

            endpointURL = endpointURL.substringBeforeLast('&');
        }
    }

    //prepare the http callout request
    public void prepareHTTPRequest() {

        req = new HTTPRequest();

        if(String.isNotEmpty(endpointURL)) {

            endpointURL = endpointURL.substringBefore('?');

            appendParametersToURL();

            req.setEndpoint(endpointURL);
        }
        if(String.isNotEmpty(requestMethod)) {

            req.setMethod(requestMethod);

        }
    }

    //get the prepared request
    public HTTPRequest getRequest() {

        prepareHTTPRequest();

        return req;
    }

    //send request
    public HTTPResponse sendRequest() {

        Http http = new Http();

        //return the reponse returned from api callout
        return http.send(req);
    }
}
