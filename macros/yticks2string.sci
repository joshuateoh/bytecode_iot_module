function yticks2string(str,n)
//  Change the ytick to string
//
// Syntax
//      yticks2string(str,n)
//
// Parameters
//     str : string input to replace the current yticks
//     n : number of ticks in y axis
//
// Description
//    This is to change the yticks to string replacing numbers
//    
// Examples
//    x = 1:10
//    plot(x,y);
//    xx = ['a','b','c','d','e','f','g','h','i','j','k'];
//    yticks2string(xx,5);
//    
// See also
//     xtick2string
//
// Authors
//     C.L. Tan, Bytecode
//

    hh = gcf();
    aa = hh.children.y_ticks;
    tt = round(linspace(1,max(size(str)),n)');
    dd = str(tt);
    aa(2) = tt;
    aa(3) = dd;
    hh.children.y_ticks  = aa;
//    hh.children.user_data = str;
    
endfunction
