function x_string_plot(x,y,n)
//  Plot a graph with x data in string format
//
// Syntax
//     x_string_plot(x,y,n)
//
// Parameters
//     x : x data in string
//     y : y daya
//     n : number of ticks in x axis
//
// Description
//    This is to plot the graph with th x data in string format. Use 3rd argument to make the x axis looks tidy
//    
// Examples
//    x = ['a','b','c','d','e','f','g','h','i','j'];
//    y = [0.84,0.91,0.14,-0.76,-0.96,-0.28,0.66,0.99,0.41,-0.54];
//    x_string_plot(x,y,5)
//    
// See also
//     x_string_datatips
//
// Authors
//     C.L. Tan, Bytecode
    
    plot(y);
    if size(x,2) > size(x,1)  then
        x = x';
    end
    hh = gcf();
    aa = hh.children.x_ticks;
    tt = round(linspace(1,max(size(y)),n)');
    dd = x(tt);
    aa(2) = tt;
    aa(3) = dd;
    hh.children.x_ticks  = aa;
    hh.children.user_data = x;
 
endfunction

