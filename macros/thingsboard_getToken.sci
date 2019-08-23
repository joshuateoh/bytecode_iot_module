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
    
    jimport okhttp3.MediaType 
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    jimport okhttp3.RequestBody
    
    bool = jautoUnwrap();
    jautoUnwrap(%t)
    
    JSON = MediaType.parse("application/json; charset=utf-8");
    thedata = '{""username"":""'+user+'"", ""password"":""'+pw+'""}'
    req_body = RequestBody.create(JSON,thedata)
    
    url_str = url+'/api/auth/login'
    reqbuilder = jnewInstance(Request$Builder)
    reqbuilder.url(url_str)
    reqbuilder.addHeader('Content-Type', 'application/json')
    reqbuilder.addHeader('Accept', 'application/json')
    reqbuilder.post(req_body)
    
    request = jinvoke(reqbuilder,"build");
    client = jnewInstance(OkHttpClient)
    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute");
    
    result_body = jinvoke(result, 'body');
    body_str = jinvoke(result_body, 'string')
    token = JSONParse(body_str)
    jautoUnwrap(bool)
endfunction
