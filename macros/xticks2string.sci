function xticks2string(str,n)
//  Change the xtick to string
//
// Syntax
//      xticks2string(str,n)
//
// Parameters
//     str : string input to replace the current xticks
//     n : number of ticks in x axis
//
// Description
//    This is to change the xticks to string replacing numbers
//    
// Examples
//    x = 1:10
//    plot(x,y);
//    xx = ['a','b','c','d','e','f','g','h','i','j','k'];
//    xticks2string(xx,5);
//    
// See also
//     ytick2string
//
// Authors
//     C.L. Tan, Bytecode
//
    
    hh = gcf();
    aa = hh.children.x_ticks;
    tt = round(linspace(1,max(size(str)),n)');
    if size(str,2) > size(str,1)  then
        str = str';
    end    
    dd = str(tt);
    aa(2) = tt;
    aa(3) = dd;
    hh.children.x_ticks  = aa;
    hh.children.user_data = str;
    
endfunction
