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
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    
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
        data = temp.data
        if data == [] then
            devices = "No device found"
        else 
            temp1 = list2vec(data.name)
            temp2 = list2vec(list2vec(data.id).id)
            devices = [temp1 temp2]
        end
    elseif result_code == 401 then
        devices = body_str;
    elseif result_code == 403 then
        devices = body_str;
    elseif result_code == 404 then
        devices = body_str;
    else
        devices = body_str;
    end
    
    
endfunction
