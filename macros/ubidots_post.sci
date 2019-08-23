function out=ubidots_post(tokenID,variableID,val)
// Post a data to Ubidots sensor's variable
//
// Syntax
//    out = ubidots_post(tokenID,sensorID,val)
//
// Parameters
//     tokenID : Token ID
//     sensorID : Sensor ID
//     val : Value to sent to the sensor source
//     out : 1 indicate data posted successfully, otherwise 0 will be returned
//
// Description
//    Post a data to a sensor source of 
//
// See also
//    ubidots_get
//    ubidots_count
//    ubidots_getdata
//    ubidots_listsource
//    ubidots_listvar
//
// Authors
//     Joshua T., C.L. Tan, Bytecode   
//
    
    // Check val input
    if ~isscalar(val) | ~isnum(string(val)) then
        error('val needs to be a scalar value');
        out = 0
    end
    
    // Send request

    [OS,Version]=getos();
    if OS == 'Windows' then
        a2=SCI+"/tools/curl/curl -X POST -H ""Content-Type: application/json"" -d {\""value\"":\"""
    else
        a2="curl -X POST -H ""Content-Type: application/json"" -d {\""value\"":\"""
    end

    a3=a2+string(val)+"\""} "
    web="http://things.ubidots.com/api/v1.6/variables/"
    web2=web+variableID+"/values/?token="+tokenID
    comb=a3+web2
    [message,stat]=unix_g(comb)
    
    // Check request status
    status = JSONParse(message);
    if  isfield(status,'detail') then
        if status.detail == 'Not found.' then
            error('Data failed to upload to Ubibots, please check the variableID.');
        elseif status.detail == "Authentication credentials were not provided." then
            error('Data failed to upload to Ubibots, please check the tokenID.');
        end
        out = 0;
        
    elseif isfield(status,'value') then
        disp('Data with value = ' + string(status.value) + ' successfully posted to Ubidots at time = ' + strsubst(status.created_at,',',':'));
        out = 1;
        
    else 
        disp(lasterror); 
        out = 0;
    end
    
endfunction
