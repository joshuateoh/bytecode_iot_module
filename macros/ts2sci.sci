function time_scilab = ts2sci(timestamp,gmt)
// Convert timestamp in milliseconds to serial date number, with GMT offset
//
// Syntax
//    time_scilab = ts2sci(timestamp,gmt)
//
// Parameters
//     timestamp : Time stamp in unix time milliseconds
//     gmt : GMT offset to get the local time
//     time_scilab : Serial date number in Scilab
//
// Description
//    Convert timestamp in milliseconds to serial date number, with GMT offset. 
//
// See also
//    ts2str 
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

    
 
endfunction
