function result = favor_sendData(api,data)
// Send data to the Favoriot cloud
//
// Syntax
//    result = favor_sendData(api,data)
//
// Parameters
//     result : A Java object that indicates the status of the data upload request 
//     api : The user's API key
//     data : The data structure to be uploaded
//
// Description
//    Uploads a data structure to the Favoriot cloud. The data structure can be created using the favor_createData function.
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
//     Joshua, C.L. Tan, Bytecode    
//

    jimport okhttp3.MediaType 
    jimport okhttp3.Request$Builder
    jimport okhttp3.OkHttpClient
    jimport okhttp3.RequestBody

    // Creating Data 
    JSON = MediaType.parse("application/json; charset=utf-8"); // Setting the media type to JSON
    thedata = favor_struct2json(data);
    req_body = RequestBody.create(JSON,thedata) // We used the 2 above to create the data body

    reqbuilder = jnewInstance(Request$Builder)
    reqbuilder.url("https://api.favoriot.com/v1/streams")
    reqbuilder.addHeader("content-type", "application/json")
    reqbuilder.addHeader("cache-control", "no-cache")
    reqbuilder.addHeader("apikey", api)
    reqbuilder.post(req_body) // Put the request body here

    request = jinvoke(reqbuilder,"build"); // Build the Request object

    client = jnewInstance(OkHttpClient)
    req_call = client.newCall(request)
    result = jinvoke(req_call,"execute"); // Send the HTTP request

endfunction


