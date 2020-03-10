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

    url_str = "https://apiv2.favoriot.com/v2/streams/"+id;
    
    curl_str = curlStr(url_str,"DELETE","header","apikey:"+api) + " -k"
    [result,stat]=unix_g(curl_str)

endfunction
