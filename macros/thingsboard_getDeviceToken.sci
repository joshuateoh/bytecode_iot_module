function [devicetoken,code] = thingsboard_getDeviceToken(url,token,deviceID)
// Retrieve a device's token
//
// Syntax
//     [devicetoken,code] = thingsboard_getDeviceToken(url,token,deviceID)
//
// Parameters
//     url : The ThingsBoard platform url
//     token : Thingsboard token
//     deviceID : Device id 
//     devicetoken : The device's token
//     code : Status code
//
// Description
//    Retrieves a device's token. This token is needed in order to push data to the device. Note that this token is different from the thingsboard_getToken's token.
//
// Examples
//    // If you want to push data to a device with id ABC123
//    data = create_JSON("temp",24,"humidity",55)
//    token = thingsboard_getToken(url,user,pw)
//    [devicetoken,code] = thingsboard_getDeviceToken(url,token,"ABC123")
//    n = thingsboard_postData(url,devicetoken,data)
//
// See also
//    thingsboard_postData
//
// Authors
//     Joshua T., Bytecode 
//    
    
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    
    url_str = url+'/api/device/'+deviceID+'/credentials'
    
    reqbuilder = jnewInstance(Request$Builder)
    reqbuilder.url(url_str)
    reqbuilder.addHeader('content-type', 'application/json')
    bear = "Bearer "+token.token
    reqbuilder.addHeader('X-Authorization',bear)
    
    request = jinvoke(reqbuilder, 'build');
    client = jnewInstance(OkHttpClient)
    req_call = client.newCall(request)
    result = jinvoke(req_call, 'execute')
    
    result_code = jinvoke(result,'code')
    result_body = jinvoke(result, 'body')
    body_str = jinvoke(result_body, 'string');
    
    code = result_code
    if result_code == 200 then
        temp = JSONParse(body_str);
        devicetoken = temp.credentialsId
    elseif result_code == 401 then
        devicetoken = body_str;
    elseif result_code == 403 then
        devicetoken = body_str;
    elseif result_code == 404 then
        devicetoken = body_str;
    else
        devicetoken = body_str;
    end
    
endfunction
