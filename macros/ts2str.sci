function timestr = ts2str(timestamp,gmt)
// Convert timestamp in milliseconds to human readable format, with GMT offset
//
// Syntax
//    timestr = ts2str(timestamp,gmt)
//
// Parameters
//     timestamp : Time stamp in unix time milliseconds
//     gmt : GMT offset to get the local time
//     timestr : Human readable format in string
//
// Description
//    Convert timestamp in milliseconds to human readable format, with GMT offset
//
// See also
//    ts2sci 
//    ts2vec 
//    vec2ts 
//    sci2ts
//    str2ts
//
// Authors
//     C.L. Tan, Bytecode  
//          
    rhs=argn(2);
    if rhs < 2; gmt = 8; end    

    time_reference = datenum(1970,1,1,gmt,0,0); 
    time_scilab = time_reference + timestamp / 8.64e7;
    timevec = datevec(time_scilab);
    
    timevec(:,$) = round(timevec(:,$))
    timestr = strcat(string(timevec),':','c');

endfunction
