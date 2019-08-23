function stringJSON = str2JSON(m,n)
// Convert Scilab string to JSON format
//
// Syntax
//    vec = [3 2 1];
//    str = vec2str(vec);
//    out = str2JSON(str,'data');
//
// Parameters
//     m : Input string
//     n : Name of object
//     stringJSON : Output in JSON format
//
// Description
//    List the variables available in Ubidots source and return the information of them.
//    
//  
// See also
//    vec2str
//
// Authors
//     C.L. Tan, Bytecode  
//     Modified from http://imgsimon.blogspot.my/2016/10/scilab-d3js-scilab-vectors-to-json-files.html

    s = size(m);
    cols = s(2);
    rows = s(1);
    
    
    // JSON syntax chars
    jsonobject_open = "{";
    bracket_opening = "[";
    bracket_closing = "]";
    quotation_mark = "'"";
    colon = ":"; 
    comma = ","; 
    jsonobject_close = "}"; 
    jsonstring = ""; 

        for j = 1:1:cols 
                jsonstring = jsonstring + bracket_opening; 
            for i = 1:1:rows 
                mat_value = string(m(i,j)); 
                    if (i ~= rows) then 
                         jsonstring = jsonstring + mat_value + comma; 
                     else  
                         jsonstring = jsonstring + mat_value; 
                     end 
             end 
                 if (j ~= cols) then 
                     jsonstring = jsonstring + bracket_closing + comma + ascii(10); 
                 else 
                     jsonstring = jsonstring + bracket_closing; 
                 end 
         end 
      
     // Opening object 
      
     //stringJSON = jsonobject_open + ascii(10) + quotation_mark + n + quotation_mark +... 
    //+ colon + ascii(10) + jsonstring + ascii(10) + jsonobject_close; 
     
     stringJSON = jsonobject_open + quotation_mark + n + quotation_mark + colon +  jsonstring + jsonobject_close; 
     
     
    disp(stringJSON) 
    //filename = n + " _json.json";
    
    //write(filename, stringJSON);
    
endfunction
