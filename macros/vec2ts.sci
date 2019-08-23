function timestamp = vec2ts(timevec,gmt)
// Convert time vector to timestamp in milliseconds, with GMT offset
//
// Syntax
//    timestamp = vec2ts(timevec,gmt)
//
// Parameters
//     timevec : Time (Date) vector.
//     gmt : GMT offset to get the local time
//     timestamp : Time stamp in unix time milliseconds
//
// Description
//    Convert time vector to timestamp in milliseconds, with GMT offset
//
// See also
//    ts2sci 
//    ts2str 
//    ts2vec 
//    sci2ts
//    str2ts
//
// Authors
//     C.L. Tan, Bytecode
//               
    rhs=argn(2);
    if rhs < 2; gmt = 8; end    
    
    time_scilab = datenum(timevec);
    time_reference = datenum(1970,1,1,gmt,0,0); 
    timestamp = (time_scilab  - time_reference)* 8.64e7;



    

endfunction
