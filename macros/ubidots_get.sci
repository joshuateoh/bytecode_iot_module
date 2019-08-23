function [timestamp, sen_val, data]=ubidots_get(tokenID,variableID,num_data)
// Retrieve data with other information as well from Ubidots sensor's variable
//
// Syntax
//    [timestamp, sen_val, data] = ubidots_get(tokenID,sensorID,num_data)
//
// Parameters
//     tokenID : Token ID
//     sensorID : Sensor ID
//     num_data : Numbers of data to get from the sensor's variable, maximum 300
//     timestamp : Time stamp in unix time milliseconds
//     sen_val : Sensor data
//     data : Structure of full details, always not required 
//
// Description
//    Get data to Ubidots sensor's variable. As this function will return all the details for each sensors data, the maximum data could be retrived by this function is 300. To get all data with only timestamp and value, use ubidots_getdata instead.
//
// See also
//    ubidots_getdata
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
    
    if num_data >= 300 then
        num_data = 300;
    end
   
   // Send request 
   str = 'http://things.ubidots.com/api/v1.6/variables/' + variableID + '/values?page_size=' + string(num_data) + '&token=' + tokenID
    [temp,message]=getURL(str);
    
    if  grep(message,"detail")==1 then
        disp(lasterror);
        error('Retrieval failed, please check the tokenID and variableID.');
        data = %nan;
                
    elseif grep(message,"count")== 1 then
        // Retrieve results
        [st,fi,ma]=regexp(message,"/\[(.*?)\]/");
        ma2 = part(ma,2:$-1);
        
        //Extract timestamp
        [temp,w2]=strsplit(ma2,"/""timestamp"":\s(.+?),/");
        timestamp=evstr(part(w2,length('""timestamp"":')+1:$-1));
        timestamp = timestamp($:-1:1);
        
        // Extract values
        [temp,w2]=strsplit(ma2,"/""value"":\s(.+?)\}/");
        sen_val=evstr(part(w2,length('""value"":')+1:$-1));
        sen_val = sen_val($:-1:1);
        
        // Extract created_at
        [temp,w2]=strsplit(ma2,"/""created_at"":\s(.+?),/");
        create=evstr(part(w2,length('""created_at"":')+1:$-1))
        create=create($:-1:1);
        
        // Extract context
        [temp,w2]=strsplit(ma2,"/""context"":\s(.+?)},/");
        context = part(w2,length('""context"":')+1:$-1)
        context = context($:-1:1);
        
        // Store in struct
        data=struct("timestamp",timestamp,"created_at",create,"context",context,"value",sen_val)
    else
        disp(lasterror);
        data = %nan;       
    end
endfunction
