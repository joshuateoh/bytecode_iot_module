function str = curlStr(url,httptype,varargin)
    // Generate a string that can be used in curl
    // In Windows, eys inside json must be enclosed in double quotes
    
    // url - Target URL
    // htpptype - HTTP type 
    // varargin - options (header, data, token)
    
     rhs = length(varargin)
    if floor(rhs/2)*2<>rhs then
        error(msprintf("Wrong number of optional input argument(s) : an even number is expected.\n"));
    end
    
    [OS,Version]=getos();
    if OS == 'Windows' then
        base=SCI+"/tools/curl/curl -X "
    else
        base="curl -X "
    end
    
    // Add HTTP Type
    add_http = base + convstr(httptype,'u')
    
    args = ""
    for i =1:2:rhs
        select convstr(varargin(i))
        case "header"
            args = args + " -H """ + varargin(i+1) + """"  
        case "data"
            if type(varargin(i+1)) == 17 // struct
                temp = toJSON(varargin(i+1))
                temp = strsubst(temp,": ",":")
            else
                temp = varargin(i+1)
            end
            temp2 = strsubst(temp,"""","\""");
            args = args + " -d " + temp2;
        case "token"
            if type(varargin(i+1)) == 17 // struct
                temp = varargin(i+1).token
            else
                temp = varargin(i+1)
            end
            args = args + " -H ""X-Authorization: Bearer "+temp+""""
        else
            error(msprintf("Wrong option. Only ""header"" or ""data"" is accepted.\n"))
        end
    end
    
    // Add the arguments
    add_args = add_http + args;
    
    // Add the target URL
    add_url = add_args + " """ + url + """"
    
    str = add_url
    
    
endfunction
