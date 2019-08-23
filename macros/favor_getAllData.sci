function data = favor_getAllData(api)
// Get all the data from all devices
//
// Syntax
//    data = favor_getAllData(api)
//
// Parameters
//     data : A structure containing the data 
//     api : The user's API key
//
// Description
//    Retrieves all the data from all devices using the API key provided by api. The structure contains 3 fields. The first field (statusCode) shows the HTTP request result (200 means success). The second field (numFound) shows the number of data found. The third field (results) contains a structure which contains the data.
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

  jimport('okhttp3.OkHttpClient');
  jimport('okhttp3.Request$Builder')
 
  reqbuilder = jnewInstance(Request$Builder)
  reqbuilder.url("https://api.favoriot.com/v1/streams")
  reqbuilder.addHeader('content-type', 'application/json')
  reqbuilder.addHeader('cache-control', 'no-cache')
  reqbuilder.addHeader('apikey', api)
 
  request = jinvoke(reqbuilder, 'build');
 
  client = jnewInstance(OkHttpClient)
  req_call = client.newCall(request)
  result = jinvoke(req_call, 'execute');// This will retrieve all data
 
  result_response = jinvoke(result, 'body');
  response_body = jinvoke(result_response, 'string');// response body can only be consumed once
  data = JSONParse(response_body)

  
   

endfunction


