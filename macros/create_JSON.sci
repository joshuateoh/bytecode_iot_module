function jsonbody = create_JSON(varargin)
// Create a JSON-formatted data
//
// Syntax
//     jsonbody = create_JSON(key1,val1)
//     jsonbody = create_JSON(key1,val1,key2,val2,...)
//
// Parameters
//     key1, key2, ..., keyn : String. Device key/variable
//     val1, val2, ..., valn : String or constant. The key's value
//     jsonbody : A data string in JSON Format 
//
// Description
//    Creates a JSON-formatted data. The input needs to be in key-value pairs.
//
// Examples
//    jsonbody = create_JSON("temp",25.5,"humidity","83%")
//
// See also
//
// Authors
//     Joshua T., Bytecode 
//    
    rhs = argn(2)
    
    if modulo(rhs,2) ~= 0
        error(msprintf("%s: Data needs to be in pair(s) of key,value.\n","create_JSON"))
    else
        body = '{';
        for i = 1:2:rhs
            
            // Checks if key is scalar
            if size(varargin(i),'*') ~= 1 
                msg = gettext("%s: Key needs to be a scalar string.\n")
                error(msprintf(msg,"create_JSON"))
            end
            // Checks if value is scalar
            if size(varargin(i+1),'*') ~= 1
                msg = gettext("%s: Value needs to be a scalar.\n")
                error(msprintf(msg,"create_JSON"))
            end
            
            // Checks if key is string
            if typeof(varargin(i)) == "string"
                body = body+'""'+varargin(i)+'"":'
            else
                msg = gettext("%s: Key needs to be a string.\n")
                error(msprintf(msg,"create_JSON"))
            end
            
            // Checks if value is either a string or constant
            if typeof(varargin(i+1)) == "string"
                body = body + varargin(i+1)
            elseif typeof(varargin(i+1)) == "constant"
                body = body + string(varargin(i+1))
            else
                msg = gettext("%s: Value needs to be either a string or a constant.\n")
                error(msprintf(msg,"create_JSON"))
            end
            if i ~= (rhs-1)
                body = body+', '
            end
        end
        body = body+'}'
    end
    jsonbody = body
endfunction

