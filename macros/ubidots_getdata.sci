function [timestamp, var_val]=ubidots_getdata(tokenID,variableID,num_data)
// Retrieve data with timestamp from Ubidots sensor's variable
//
// Syntax
//    [timestamp, sen_val, data] = ubidots_get(tokenID,sensorID,num_data)
//
// Parameters
//     tokenID : Token ID
//     sensorID : Sensor ID
//     num_data : Numbers of data to get from the sensor's variable
//     timestamp : Time stamp in unix time milliseconds
//     sen_val : Sensor data
//
// Description
//    Get all data to Ubidots sensor's variable. This function will only return the timestamp and sensor value but no other details. 
//
// See also
//    ubidots_get
//    ubidots_count
//    ubidots_listsource
//    ubidots_listvar
//    ubidots_post 
//
// Authors
//     Joshua T., C.L. Tan, Bytecode 
//
    
    
    rhs=argn(2);
    if rhs < 2; error('At least 2 inputs required : tokenID,variableID' ); end  
    if rhs < 3; num_data = 10; end  
   
   // Send request
   str = 'http://things.ubidots.com/api/v1.6/variables/' + variableID + '/values?page_size=' + string(num_data) + '&token=' + tokenID
    [temp,message]=getURL(str);
    
    if  grep(message,"detail")==1 then
        disp(lasterror);
        error('Retrieval failed, please check the tokenID and variableID.');
        var_val = %nan;
        timestamp = %nan;
                
    elseif grep(message,"count")== 1 then
        // Retrieve results
        [st,fi,ma]=regexp(message,"/\[(.*?)\]/");
        ma2 = part(ma,2:$-1);
        
        // Extract timestamp
        [temp,w2]=strsplit(ma2,"/""timestamp"":\s(.+?),/");
        timestamp=evstr(part(w2,length('""timestamp"":')+1:$-1));
        timestamp = timestamp($:-1:1);
        
        // Extract the values
        [temp,w2]=strsplit(ma2,"/""value"":\s(.+?)\}/");
        var_val=evstr(part(w2,length('""value"":')+1:$-1));
        var_val = var_val($:-1:1);
        
    else
        disp(lasterror);
        //data = %nan;
        var_val = %nan;
        timestamp = %nan;           
    end
endfunction
