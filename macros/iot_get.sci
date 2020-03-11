function data = iot_get(obj,varargin)
// Retrieve data from the cloud
//
// Syntax
//    data = iot_get(obj,"key",key)
//
// Parameters
//    obj = A struct created using iot_init
//    key = A string of the key ("temperature","voltage", etc)
//
//
// Description
//    Retrieves data from the cloud
//
//
// See also
//    iot_send
//    iot_get
//
// Authors
//     Joshua T., Bytecode 
//    
    
    opts = struct("key","","limit","")
    
    rhs = length(varargin)
    if floor(rhs/2)*2<>rhs then
        error(msprintf("Arguments need to be in key-value pairs.\n"));
    end
    for i =1:2:rhs
           select convstr(varargin(i))
           case "key"
               opts.key = varargin(i+1)
           case "limit"
               opts.limit = string(varargin(i+1))
           case "field"
               opts.key = string(varargin(i+1))
           else
               error(msprintf("Wrong options.\n"))
           end
       end
    
    select obj.cloud
    case "thingsboard"
        format_width = format()
        format("v",20)
        
        ts_end = round(vec2ts(clock()))
        days_ms = 24*60*60*1000*100
        ts_start = ts_end - days_ms
        url_get = obj.url_get+opts.key+"&startTs="+string(ts_start)+"&endTs="+string(ts_end)
        url_str = curlStr(url_get,"GET","header","Content-Type: application/json","token",obj.token)
        url_str = url_str + " -k"
        [message,stat]=unix_g(url_str);
        data = fromJSON(message);
         

        format("v",format_width(2))
    case "ubidots"
        if opts.limit == "" // no limit argument
            [data, status] = http_get(obj.url_get)
        else
            tempurl = obj.url_get+"&page_size="+opts.limit
            [data, status] = http_get(tempurl)
        end
        
    case "thingspeak"
        tempurl = strsubst(obj.url_get,"_FIELDNBR_",opts.key)
        [data, status] = http_get(tempurl)
        
    case "favoriot"
        str = curlStr(obj.url_get,"GET","header","apikey:"+obj.read_acc)
        str = str + " -k"
        [message,stat]=unix_g(str);
        data = fromJSON(message);
        
    else
         error(msprintf("The specified cloud %s is not supported.\n",obj.cloud))
    end
    
    
endfunction
