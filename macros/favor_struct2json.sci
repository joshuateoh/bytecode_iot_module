function data = favor_struct2json(st)
// Converts a data structure to JSON format
//
// Syntax
//    data = favor_struct2json(st)
//
// Parameters
//     data : The data in JSON format 
//     st : The data structure
//
// Description
//    Converts the data structure into JSON format. The data structure is obtained from the function favor_CreateData.
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
    
    // JSON syntax chars
    ob = "{";
    cb = "}"; 
    qm = "\""";
    cl = ":"; 
    cm = ","; 
    
    str_start = "{ \""device_developer_id\"": \""" + st.device_developer_id + "\"", \""data\"": {";
    str_end = "}}";

    fn = fieldnames(st.data);
    str_data = '';
    for cnt = 1:size(fn,1)
        if type(evstr("st.data."+fn(cnt))) == 1
            str_data = str_data + qm + fn(cnt) + qm + cl + qm + string(evstr("st.data."+fn(cnt)))+ qm + cm;
        else
            
            str_data = str_data + qm + fn(cnt) + qm + cl + qm + evstr("st.data."+fn(cnt))+ qm + cm;
        end
    end
    
        
    data = str_start + part(str_data,1:$-1) + str_end;
      
    
endfunction
