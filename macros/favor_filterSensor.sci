function sensor = favor_filterSensor(obj,field)
// Extract data from a specified sensor
//
// Syntax
//    sensor = favor_filterSensor(data,sensorName)
//
// Parameters
//     sensor : A structure containing the extracted data of a sensor 
//     data : The data structure
//     sensorName : The name of the sensor to be used
//
// Description
//    Extracts the data of a sensor from a data structure (obtained from the function favor_getAllData or favor_getDeviceData). The extracted data contains the time as well as the values
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

    sz = obj.numFound;
    cnt0 = 1;
    
    for cnt = 1:sz
        if isfield(obj.results(cnt).data,field)
            y(cnt0) = getfield(field,obj.results(cnt).data);
            x(cnt0) = obj.results(cnt).stream_created_at;
            cnt0 = cnt0+1
        end          
    end
    
    sensor.x=x;
    sensor.y=y;
endfunction


