function out = iot_send(obj,key,value)
// Sends data to the cloud
//
// Syntax
//    out = iot_sen(obj,key,value)    
//
//
// Parameters
//    obj = A struct created using iot_init
//    key = A string of the key ("temperature","voltage", etc)
//    value = Value of the key
//    out = Response from the cloud
//
// Description
//    Sends data to the cloud
//
// See also
//    iot_init
//    iot_get
//
// Authors
//     Joshua T., Bytecode 
//    
    
    select obj.cloud
    case "thingsboard"
        data = struct(key,value)
        [result, out] = http_post(obj.url_post, data)
    case "ubidots"
        data = struct(key,value)
        str = curlStr(obj.url_post,"POST","header","Content-Type: application/json","data",data)
        [message,stat]=unix_g(str)
        out = fromJSON(message)
        
    case "thingspeak"
        str = obj.url_post+"&field"+string(key)+"="+string(value)
        [result, out] = http_get(str)
        
    case "favoriot"
        body = struct("device_developer_id",obj.deviceid,"data",struct(key,value))
        str = curlStr(obj.url_post,"POST","header","Content-Type: application/json","header","Cache-Control: no-cache","header","apikey: "+obj.post_acc,"data",body)
        str = str + " -k"
        [message,stat]=unix_g(str)
        out = fromJSON(message)
        
    else
         error(msprintf("The specified cloud %s is not supported.\n",obj.cloud))
    end
    
endfunction
