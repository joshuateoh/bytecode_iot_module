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
    
    jimport okhttp3.MediaType 
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    jimport okhttp3.RequestBody
    
    JSON = MediaType.parse("application/json; charset=utf-8");
    thedata = '{""refreshToken"":""'+oldtoken.refreshToken+'""}'
    req_body = RequestBody.create(JSON,thedata)
    
    bear = "Bearer "+oldtoken.token
    
    reqbuilder = jnewInstance(Request$Builder)
    url_str = url+'/api/auth/token'
    reqbuilder.url(url_str)
    reqbuilder.addHeader('Content-Type', 'application/json')
    reqbuilder.addHeader('Accept', 'application/json')
    reqbuilder.addHeader('X-Authorization',bear)
    reqbuilder.post(req_body)
    
    request = jinvoke(reqbuilder,"build");
    client = jnewInstance(OkHttpClient)
    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute");
    
    result_body = jinvoke(result, 'body');
    body_str = jinvoke(result_body, 'string')
    newtoken = JSONParse(body_str)
    
endfunction
