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

    url_str = "https://apiv2.favoriot.com/v2/streams"
    
    curl_str = curlStr(url_str,"POST","header","Content-Type: application/json","header","apikey:"+api,"data",data) + " -k"
    
    [result,stat]=unix_g(curl_str)

endfunction


