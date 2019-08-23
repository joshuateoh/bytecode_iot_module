function timevec = ts2vec(timestamp,gmt)
// Convert timestamp in milliseconds to time vector, with GMT offset
//
// Syntax
//    timevec = ts2vec(timestamp,gmt)
//
// Parameters
//     timestamp : Time stamp in unix time milliseconds
//     gmt : GMT offset to get the local time
//     timevec : Time (Date) vector.
//
// Description
//    Convert timestamp in milliseconds to time vector, with GMT offset.
//
// See also
//    ts2sci 
//    ts2str 
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
    

endfunction
