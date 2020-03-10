function n = thingsboard_postData(url,posttoken,data)
// Push data to ThingsBoard
//
// Syntax
//     n = thingsboard_postData(url,posttoken,jsonbody)
//
// Parameters
//     url : The ThingsBoard platform url
//     posttoken : Device post token
//     data : A data struct containing the keys and values
//     n : Status code
//
// Description
//    Push data to a device in ThingsBoard. The device post token is different from the token used in retrieving data. 
//
// Examples
//    // If your Thingsboard device has an access token of ABC123
//    acc_token = "ABC123"
//    data = struct("temp",24,"humidity",55)
//    n = thingsboard_postData(url,acc_token,data)
//
// See also
//    thingsboard_getDeviceToken
//
// Authors
//     Joshua T., Bytecode 
//    
    
    url_str = url+"/api/v1/"+posttoken+"/telemetry"
    
    [result, n] = http_post(url_str, data)
    
endfunction
