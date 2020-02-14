function x_string_datatips()
//  Add a datatips with x axis as string
//
// Syntax
//     x_string_datatips()
//
// Parameters
//
// Description
//    This is to create a new datatip by using the x-axis string instead of numerical value
//    
//    
// See also
//     x_string_plot
//
// Authors
//     C.L. Tan, Bytecode
    
    e=gce();e=e.children;    
    d1=datatipCreate(e(1),700);
    x = e.parent.parent.user_data;
    datatipSetDisplay(d1,"iot_display")
endfunction





