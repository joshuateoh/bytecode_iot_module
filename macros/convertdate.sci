function datestr = convertdate(x,tgt,src)
// Convert date format
//
// Syntax
//     datestr = convertdate(x)
//     datestr = convertdate(x,tgt)
//     datestr = convertdate(x,tgt,src)
//
// Parameters
//     x : String vector/scalar. Input date
//     tgt : String. Target date format. Default is "yyyy.MM.dd.HH.mm.ss"
//     src : String. Input date format. Default assumed to be "EEE MMM dd HH:mm:ss z yyyy"
//     datestr : String vector/scalar. Returned date in new format 
//
// Description
//    This function converts the date's format to another format
//    
// Examples
//      // Example 1
//      datestr1 = convertdate("Mon Aug 05 14:38:00 MYT 2019")
//      // Example 2
//      newformat = "yyyy/MM/dd HH:mm:ss"
//      datestr2 = convertdate("Mon Aug 05 14:38:00 MYT 2019",newformat)
//      // Example 3
//      oldformat = "dd-MMM-yyyy HH:mm"
//      newformat = "HH:mm:ss MM/dd/yy"
//      datestr3 = convertdate("05-Aug-2019 14:38",newformat,oldformat)
// 
// See also
//
// Authors
//     Joshua T., Bytecode

    jimport java.text.SimpleDateFormat

    rhs=argn(2);
    
    // Error Checking
    if rhs < 1; error("Expect a least 1 argument."); end 

    if rhs == 1   
        oldformat = SimpleDateFormat.new("EEE MMM dd HH:mm:ss z yyyy"); 
        newformat = SimpleDateFormat.new("yyyy.MM.dd.HH.mm.ss");
    elseif rhs == 2
        oldformat = SimpleDateFormat.new("EEE MMM dd HH:mm:ss z yyyy"); 
        newformat = SimpleDateFormat.new(tgt);
    elseif rhs == 3
        oldformat = SimpleDateFormat.new(src); 
        newformat = SimpleDateFormat.new(tgt); 
    end

    xr = size(x);
    datestr = emptystr(xr(1),xr(2));

    for i = 1:prod(xr)
        tempdate = oldformat.parse(x(i));
        datestr(i) = newformat.format(tempdate);
    end
    

endfunction
