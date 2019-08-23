function timestamp = str2ts(timestr,gmt)
// Convert human readable format date to timestamp in milliseconds, with GMT offset
//
// Syntax
//    timestamp = str2ts(timestr,gmt)
//
// Parameters
//     timestr : Human readable format in string
//     gmt : GMT offset to get the local time
//     timestamp : Time stamp in unix time milliseconds
//
// Description
//    Convert human readable format date to timestamp in milliseconds, with GMT offset
//
// See also
//    ts2sci 
//    ts2str 
//    ts2vec 
//    vec2ts 
//    sci2ts
//
// Authors
//     C.L. Tan, Bytecode  
//               
    rhs=argn(2);
    if rhs < 2; gmt = 8; end    
    
    time_scilab = datenum(strtod(strsplit(timestr,'.'))')
    time_reference = datenum(1970,1,1,gmt,0,0); 
    timestamp = (time_scilab  - time_reference)* 8.64e7;

    

endfunction
