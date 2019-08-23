function result = favor_delDataStream(api,id)
// Delete the data dtream in favoriot with given id. 
//
// Syntax
//    result = favor_delDataStream(api,id)
//
// Parameters
//     result : Status for the command
//     api : The user's API key
//     id : Data stream id
//
// Description
//    This function is used to delete the data stream in the favoriot account with the data stream id. We could use loop to delete the undesired data streams. 
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

    reqbuilder.url("https://api.favoriot.com/v1/streams/"+id)
    reqbuilder.addHeader("content-type", "application/json")
    reqbuilder.addHeader("cache-control", "no-cache")
    reqbuilder.addHeader("apikey", api)
    request = jinvoke(reqbuilder,"delete")
    request = jinvoke(reqbuilder,"build") // Build the Request object

    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute")  // Send the HTTP request
endfunction
