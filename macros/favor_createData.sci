function obj = favor_createData(id,varargin)
// Create a data structure to be uploaded to Favoriot
//
// Syntax
//    obj = favor_createData(deviceID,sensorName)
//
// Parameters
//     obj : A data structure 
//     deviceID : Device developer ID
//     sensorName : Name of the sensors that will be used
//
// Description
//    Create a data structure to be uploaded to Favoriot. The data structure contains 2 fields. The first field (device_developer_id) contains the device developer ID provided by deviceID. The second field (data) contains a structure with the sensor names provided by sensorName. You can use the function favor_createSensors to generate sensor names. The sensors will have the default value of "0". 
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

    [lhs,rhs]=argn(0);
    if rhs==0 then
        obj.device_developer_id = 'default@userid';
        obj.data.sensor1 = 0;
        obj.data.sensor2 = 0;
    elseif rhs == 1
        obj.device_developer_id = id;
        obj.data.sensor1 = 0;
        obj.data.sensor2 = 0;
    elseif rhs > 1
        obj.device_developer_id = id;
              
        str2 = strcat(''''+list2vec(varargin) + ''',''0'',');
        str2 = part(str2,1:$-1);
        str = 'struct(' + str2 + ')';
        data = evstr(str);
        obj.data = data;
    end   

endfunction
