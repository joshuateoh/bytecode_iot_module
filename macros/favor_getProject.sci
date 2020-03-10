function out = favor_getProject(api,id)
// Get the properties of a specified project
//
// Syntax
//    out = favor_getApplication(api,id)
//
// Parameters
//     out : A structure containing the project's properties 
//     api : The user's API key
//     id : Project developer ID
//
// Description
//    Retrieves a specified project and its properties. The properties of the project are stored inside the structure's third field (results).
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

    url_str = "https://apiv2.favoriot.com/v2/projects/"+id
    
    curl_str = curlStr(url_str,"GET","header","apikey:"+api) + " -k"
    
    [message,stat]=unix_g(curl_str);
    out = fromJSON(message);
    
endfunction



