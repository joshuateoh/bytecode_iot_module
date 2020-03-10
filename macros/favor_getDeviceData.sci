function data = favor_getDeviceData(api,id)
// Get all the data from a specified device
//
// Syntax
//    data = favor_getDeviceData(api,id)
//
// Parameters
//     data : A structure containing the data 
//     api : The user's API key
//     id : Device developer ID
//
// Description
//    Retrieves all the data from a specified device using the API key provided by api. The structure contains 3 fields. The first field (statusCode) shows the HTTP request result (200 means success). The second field (numFound) shows the number of data found. The third field (results) contains a structure which contains the data.
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

    url_str = "https://apiv2.favoriot.com/v2/streams?device_developer_id="+id
    
    curl_str = curlStr(url_str,"GET","header","apikey:"+api) + " -k"
    
    [message,stat]=unix_g(curl_str);
    data = fromJSON(message);
    
endfunction


