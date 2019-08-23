function str = favor_createSensors(n)
// Create a string array of sensor names
//
// Syntax
//    str = favor_createSensors(n)
//
// Parameters
//     str : A string array of sensor names
//     n : The number of sensor names to be generated
//
// Description
//    Create a string array of sensor names. This can be used as one of the inputs for the function favor_createData.
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

str = [];
for cnt = 1:n
    str(cnt) = 'Sensor' + string(cnt);
end
  
endfunction
