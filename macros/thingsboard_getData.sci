function data = thingsboard_getData(url,token,deviceID,key,n,day_limit)
// Retrieves data from Thingsboard
//
// Syntax
//    data = thingsboard_getData(url,token,deviceID,key,n)
//    data = thingsboard_getData(url,token,deviceID,key,n,day_limit)
//
// Parameters
//     url : The ThingsBoard platform url
//     token : ThingsBoard token
//     deviceID : Device ID
//     key : The device's variable where the data will be extracted
//     n : The maximum number of data to be pulled
//     day_limit : The limit on the earliest data to be pulled
//
// Description
//    Retrieves the data from a variable of a device in ThingsBoard.
//
// Examples
//     // If your device id is ABC123 and contains a variable called temp
//     deviceID = "ABC123"
//     key = "temp"
//     token = thingsboard_getToken(url,user,pw)
//     data = thingsboard_getData(url,token,deviceID,key,100)
//
// See also
//    thingsboard_getToken
//    thingsboard_postData
//
// Authors
//     Joshua T., Bytecode 
//    

    format_width = format()
    format("v",20)
    
    ts_end = round(vec2ts(clock()))
    
    rhs = argn(2)
    if rhs == 6 then
        days_ms = 24*60*60*1000*day_limit
    elseif rhs == 5
        days_ms = 24*60*60*1000*100 // put a large duration
    else
        error(msprintf("%s: Wrong number of inputs.\n","thingsboard_getData"))
    end
    
    ts_start = ts_end - days_ms
    
    url_str = url+"/api/plugins/telemetry/DEVICE/"+deviceID+"/values/timeseries?keys="+key+"&startTs="+string(ts_start)+"&endTs="+string(ts_end)+"&limit="+string(n)
    
    curl_str = curlStr(url_str,"GET","header","Content-Type: application/json","token",token)
    curl_str = curl_str + " -k"
    [message,stat]=unix_g(curl_str);
    data = fromJSON(message); 
    
    format("v",format_width(2))
    
endfunction
