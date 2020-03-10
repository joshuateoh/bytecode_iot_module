function [devices, code] = thingsboard_getDevices(url,token,namefilter,ndev)
// Retrieve a user's list of devices
//
// Syntax
//    [devices, code] = thingsboard_getDevices(url,token)
//    [devices, code] = thingsboard_getDevices(url,token,namefilter)
//    [devices, code] = thingsboard_getDevices(url,token,namefilter,ndev)
//
// Parameters
//     url : The ThingsBoard platform url
//     token : Thingsboard token
//     namefilter : A string to filter devices based on the name 
//     ndev : Maximum number of devices to be retrieved
//     devices : A N by 2 string array containing the device name and ID
//     code : Status code
//
// Description
//    Retrieves a user's devices' name and ID. Devices with specific names can be filtered using namefilter.
//
// Examples
//    // Retrieve all the user's devices
//    token = thingsboard_getToken(url,user,pw)
//    [devices,code] = thingsboard_getDevices(url,token)
//    // Retrieve the user's devices that contains "test" in their name
//    [devices,code] = thingsboard_getDevices(url,token,"test")
//
// See also
//    thingsboard_getDeviceToken
//
// Authors
//     Joshua T., Bytecode 
//    
    
    jimport java.util.Base64
    jimport java.lang.String
    
    rhs = argn(2);
    
    if rhs == 4 then
        n =ndev;
    else
        n = 100; // Max number of devices to retrieve
    end
    
    // Obtain Customer ID from token
    decoder = Base64.getMimeDecoder()
    token_encoded =  token.token;
    token_decoded = decoder.decode(token_encoded)
    token_string = junwrap(String.new(token_decoded))
    [temp1,temp2,custID] = regexp(token_string,"/(?<=customerId"":"")(.*)(?="",""iss)/")
    
    if rhs >= 3 then
        url_str = url+'/api/customer/'+custID+'/devices?limit='+string(n)+'&textSearch='+namefilter
    else
        url_str = url+'/api/customer/'+custID+'/devices?limit='+string(n)
    end
        
    curl_str = curlStr(url_str,"GET","header","Content-Type: application/json","token",token)
    
    [message,stat]=unix_g(curl_str);
    message_st = fromJSON(message); 
    
    
    if isfield(message_st,"data") then
        if message_st.data ~= [] then
            devices = list2vec(message_st.data.name)
            code = 200
        else
            devices = []
            code = 200
        end
    else
        devices = message_st.message
        code = message_st.status
    end
    
endfunction
