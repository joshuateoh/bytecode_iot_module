function out = favor_getApplication(api,id)
// Get the properties of a specified application
//
// Syntax
//    out = favor_getApplication(api,id)
//
// Parameters
//     out : A structure containing the application's properties 
//     api : The user's API key
//     id : Application developer ID
//
// Description
//    Retrieves a specified application and its properties. The properties of the application are stored inside the structure's third field (results).
//
// See also
//    favor_createData
//    favor_createSensors
//    favor_filterSensor
//    favor_getAllApplications
//    favor_getAllData 
//    favor_getAllDevices
//    favor_getAllGroups
//    favor_getAllProjects
//    favor_getApplication
//    favor_getDevice
//    favor_getDeviceData
//    favor_getGroup
//    favor_getProject
//    favor_sendData
//    favor_struct2json
//
// Authors
//     Joshua T., C.L. Tan, Bytecode    
//

    jimport okhttp3.OkHttpClient;
    jimport okhttp3.Request$Builder

    client = jnewInstance(OkHttpClient);
    reqbuilder = jnewInstance(Request$Builder)

    reqbuilder.url("https://api.favoriot.com/v1/apps/"+id)
    reqbuilder.addHeader("content-type", "application/json")
    reqbuilder.addHeader("cache-control", "no-cache")
    reqbuilder.addHeader("apikey", api)
    request = jinvoke(reqbuilder,"build") // Build the Request object

    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute")  // Send the HTTP request

    result_response=jinvoke(result,"body")
    response_body = jinvoke(result_response,"string") // response body can only be consumed once
    //out = response_body;
    out = JSONParse(response_body)
    
endfunction
