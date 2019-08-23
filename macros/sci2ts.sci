function timestamp = sci2ts(time_scilab,gmt)
// Convert serial date number to timestamp in milliseconds, with GMT offset
//
// Syntax
//    timestamp = sci2ts(time_scilab,gmt)
//
// Parameters
//     time_scilab : Serial date number in Scilab
//     gmt : GMT offset to get the local time
//     timestamp : Time stamp in unix time milliseconds
////
// Description
//    Convert serial date number to timestamp in milliseconds, with GMT offset
//
// See also
//    ts2sci 
//    ts2str 
//    ts2vec 
//    vec2ts 
//    str2ts
//
// Authors
//     C.L. Tan, Bytecode    
//          
    rhs=argn(2);
    if rhs < 2; gmt = 8; end    
    
    time_reference = datenum(1970,1,1,gmt,0,0); 
    timestamp = (time_scilab  - time_reference)* 8.64e7;

 
endfunction
