function token = thingsboard_getToken(url,user,pw)
// Retrieves a ThingsBoard token.
//
// Syntax
//     token = thingsboard_getToken(url,user,pw)
//
// Parameters
//     url : The ThingsBoard platform url
//     user : Username
//     pw : password
//     token : A struc containing the token ID and refresh token ID
//
// Description
//    Retrieves a ThingsBoard token ID using the username and password. The token allows a user to pull data from ThingsBoard. The token expires after a period of time and needs to be refreshed.
//
// Examples
//     url = "http://thingsboardwebsite"
//     user = "username@useremail.com"
//     pw = "userpassword"
//     token = thingsboard_getToken(url,user,pw)
//
// See also
//    thingsboard_refreshToken
//
// Authors
//     Joshua T., Bytecode 
//    
    
    if part(url,$) == "/" then
        url2 = part(url,1:$-1)
    else
        url2 = url
    end
    
    url_str = url2+'/api/auth/login'
    
    data_st = struct("username", user, "password", pw)
    [token, status] = http_post(url_str,data_st)
    
endfunction
