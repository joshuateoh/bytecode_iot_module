function y=ubidots_count(tokenID,variableID)
// Check the number of data in a Ubidots sensor's variable
//
// Syntax
//    y=ubidots_count(tokenID,variableID)
//
// Parameters
//     tokenID : Token ID
//     sensorID : Sensor ID
//     y : Total number of data
//
// Description
//    Check the number of data in a Ubidots sensor's variable
//
// See also
//    ubidots_get
//    ubidots_getdata
//    ubidots_post
//    ubidots_listsource
//    ubidots_listvar
//
// Authors
//     Joshua T., C.L. Tan, Bytecode    
//
    
    // check number of arguments
    rhs=argn(2);
    if rhs ~= 2; error('2 inputs required : tokenID,variableID' ); end
    
    // check length of variableID
    if length(variableID)~=24; error('variableID is a 24 character string')
    end
    
    // Get the current timestamp
    ct=getdate();
    serial_date=datenum(ct(1),ct(2),ct(6),ct(7),ct(8),ct(9))
    gmt=8
    time_reference = datenum(1970,1,1,gmt,0,0);
    timestamp = (serial_date - time_reference)* 8.64e7
    timestamp_str=sprintf("%.0f",timestamp)
    
    // Send Request
    str='http://things.ubidots.com/api/v1.6/variables/'+variableID+'/statistics/count/0/'+timestamp_str+'/?token='+tokenID
    
    [OS,Version]=getos();
    if OS == 'Windows' then
        str2=SCI+"/tools/curl/curl "+str
    else
        str2="curl "+str
    end
    
    
    
    [message,stat]=unix_g(str2)
    
    // check length of temp
    if size(message,1) ~= 1; error('Retrieval failed. Please check variableID.')
    end
    
    // Parse the message
    status=JSONParse(message)
    
    // Check message
    if  isfield(status,'detail'); error('Please check tokenID.')
    elseif isfield(status,'count'); y=status.count;
    else disp(lasterror); end 
    
endfunction
