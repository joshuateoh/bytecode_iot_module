function y = vec2str(x)
// Convert Scilab vector to string
//
// Syntax
//    y = vec2str(x)
//
// Parameters
//     x : Input vector
//     y : Output string
//
// Description
//    Convert the input Scilab vector (in double) to string
//    
// Examples
//    vec = [3 2 1];
//    str = vec2str(vec);
//    out = str2JSON(str,'data');
//  
// See also
//    str2JSON
//
// Authors
//     C.L. Tan, Bytecode 

 
    y = '['+strcat(string(x),',')+']';
endfunction
