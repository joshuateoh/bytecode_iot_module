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
    
    url_str = url+'/api/device/'+deviceID+'/credentials'
    
    curl_str = curlStr(url_str,"GET","header","Content-Type: application/json","token",token)
    
   [message,stat]=unix_g(curl_str);
    message_st = fromJSON(message); 

    if isfield(message_st,"credentialsId")
        devicetoken = message_st.credentialsId
        code = 200
    else
        devicetoken = message_st.message
        code = message_st.status
    end
    
endfunction
