function n = thingsboard_postData(url,posttoken,jsonbody)
// Push data to ThingsBoard
//
// Syntax
//     n = thingsboard_postData(url,posttoken,jsonbody)
//
// Parameters
//     url : The ThingsBoard platform url
//     posttoken : Device post token
//     jsonbody : A data string in JSON Format 
//     n : Status code
//
// Description
//    Push data to a device in ThingsBoard. The device post token is different from the token used in retrieving data. The data needs to be in the form of JSON format which can be created using create_JSON.
//
// Examples
//    // If you want to push data to a device with id ABC123
//    data = create_JSON("temp",24,"humidity",55)
//    token = thingsboard_getToken(url,user,pw)
//    [devicetoken,code] = thingsboard_getDeviceToken(url,token,"ABC123")
//    n = thingsboard_postData(url,devicetoken,data)
//
// See also
//    create_JSON
//    thingsboard_getDeviceToken
//
// Authors
//     Joshua T., Bytecode 
//    
    
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    jimport okhttp3.MediaType 
    jimport okhttp3.RequestBody
    
    JSON = MediaType.parse("application/json; charset=utf-8");
    req_body = RequestBody.create(JSON,jsonbody)
    
    url_str = url+"/api/v1/"+posttoken+"/telemetry"
    
    reqbuilder = jnewInstance(Request$Builder)
    reqbuilder.url(url_str)
    reqbuilder.addHeader('Content-Type', 'application/json')
    reqbuilder.post(req_body)
    
    request = jinvoke(reqbuilder,"build")
    client = jnewInstance(OkHttpClient)
    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute")
    
    result_code = jinvoke(result, 'code')
    n =  result_code
    
endfunction
