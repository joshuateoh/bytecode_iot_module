function newtoken = thingsboard_refreshToken(url,oldtoken)
// Refreshes a ThingsBoard token.
//
// Syntax
//     newtoken = thingsboard_refreshToken(url,oldtoken)
//
// Parameters
//     url : The ThingsBoard platform url
//     oldtoken : A struc containing the expired token
//     newtoken : A struc containing the new token
//
// Description
//    Refreshes an expired ThingsBoard token using the old token. If the refresh token has also expired, you need to retrieve a new token using thingsboard_getToken
//
// Examples
//    token = thingdboard_getToken(url,user,pw)
//    // After some time, the token will expire and needs to be refreshed
//    token = thingsboard_refreshToken(url,token)
//
// See also
//    thingsboard_getToken
//
// Authors
//     Joshua T., Bytecode
//    
    
    url_str = url+'/api/auth/token'
    
    data = struct("refreshToken",oldtoken.refreshToken)
    
    curl_str = curlStr(url_str,"POST","header","Content-Type: application/json","token",oldtoken.token,"data",data)
    
    [message,stat]=unix_g(curl_str);
    newtoken = fromJSON(message); 
    
endfunction
