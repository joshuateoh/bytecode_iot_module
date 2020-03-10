function out = favor_getAllApplications(api)
// Get all the applications of a user
//
// Syntax
//    out = favor_getAllApplications(api)
//
// Parameters
//     out : A structure containing the applications' properties 
//     api : The user's API key
//
// Description
//    Retrieves all the applications of a user using the API key provided by api. The structure contains 3 fields. The first field (statusCode) shows the HTTP request result (200 means success). The second field (numFound) shows the number of applications found. The third field (results) contains a structure which contains all the properties of the applications.
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

    url_str = "https://apiv2.favoriot.com/v2/apps"
    
    curl_str = curlStr(url_str,"GET","header","apikey:"+api) + " -k"
    [message,stat]=unix_g(curl_str);
    out = fromJSON(message);

    
endfunction
