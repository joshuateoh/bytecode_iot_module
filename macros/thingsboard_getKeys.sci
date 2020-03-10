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
    
    url_str = url+'/api/plugins/telemetry/DEVICE/'+deviceID+'/keys/timeseries'
    
    curl_str = curlStr(url_str,"GET","header","Content-Type: application/json","token",token)
    
    [message,stat]=unix_g(curl_str);
    keys = fromJSON(message); 
    
    
endfunction
