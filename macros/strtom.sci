function y = strtom(x,hh)
// Convert string to matrix
//
// Syntax
//      y = strtom(x,hh)
//
// Parameters
//     x : Data in string
//     hh : Offset from the begining
//     y : Output data in double
//
// Description
//    This is to convert a string variable into double matrix 
//    
// Examples
//    str = ['1 2 3 4 5;6 7 8 9 10'];
//    strtom(str)
// 
// See also
//
// Authors
//     C.L. Tan, Bytecode
// 
    rhs=argn(2);
    if rhs < 1; error("At least one data required"); end    
    if rhs < 2; hh = 0; end
    
    x2 = tokens(x,ascii(10));
    x3 = x2(hh+1:$);
    r = size(x3,1);
    c = size(tokens(x3(1)),1);
    y =ones(r,c).*%nan;
    cntin = 1;
    for cnt = 1:size(x3,1)
            ynew = strtod(tokens(x3(cnt))');
           y(cnt,1:size(ynew,2)) = ynew;
    end
endfunction
