function keys = thingsboard_getKeys(url,token,deviceID)
// Retrieves the keys (variables) from a device in ThingsBoard.
//
// Syntax
//     keys = thingsboard_getKeys(url,token,deviceID)
//
// Parameters
//     url : The ThingsBoard platform url
//     token : ThingsBoard token
//     deviceID : Device ID
//     keys : A string array of the keys
//
// Description
//    Retrieves the keys (variables) of a device in ThingsBoard. Data pushed to the device are stored in these keys.
//
// Examples
//    // If you want to retrieve the variables in the device with id ABC123
//    token = thingsboard_getToken(url,user,pw)
//    keys = thingsboard_getKeys(url,token,"ABC123") 
//
// See also
//    thingsboard_getData
//
// Authors
//     Joshua T., Bytecode 
//    
    
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    
    url_str = url+'/api/plugins/telemetry/DEVICE/'+deviceID+'/keys/timeseries'
    
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
    
    if result_code == 403 then
        keys = body_str
    else
        keys = JSONParse(body_str)'
    end
    

    
endfunction
