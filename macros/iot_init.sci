function obj = iot_init(cloud,varargin)
// Initialize a connection to a cloud
//
// Syntax
//    obj = iot_init(cloud)
//    obj = iot_init(cloud,options)
//
// Parameters
//     cloud : A string containing the name of the cloud to be connected.
//     options : Key-value pair arguments required to initialize. Varies between clouds.
//     obj : A struct containing information needed to be used by iot_sen and iot_get

//
// Description
//    Initialize a connection to a cloud. Supported clouds are Thingsboard, Favoriot, Ubidots and Thingspeak. Each cloud has their own requirements. Running the function with just the cloud name will bring up a GUI to prompt the user to enter information.
//
// Examples
//     // Thingsboard
//     tb1 = iot_init("thingsboard")
//     // Favoriot
//     fv1 = iot_init("favoriot")
//     // Ubidots
//     ub1 = iot_init("ubidots")
//     // Thingspeak
//     ts1 = iot_init("thingspeak")
//
// See also
//    iot_send
//    iot_get
//
// Authors
//     Joshua T., Bytecode 
//    
    
    // Create empty object
    obj = struct("cloud",convstr(cloud),"url_base","","url_post","","url_get","","deviceid","","post_acc","","read_acc","","auth","","token","","variableid","")
    
    rhs = argn(2)
    
    if rhs == 1 then
        // Trigger GUI
        select convstr(cloud)
        case "thingsboard"
            params = ["Base URL","Device ID","Device Access Token","Username","Password"] 
            default = ["https://demo.thingsboard.io","","","",""]
            message = ["Please input the following parameters."]
            gui_val = x_mdialog(message,params,default)
            
            obj.url_base = gui_val(1)
            obj.deviceid = gui_val(2)
            obj.post_acc = gui_val(3)
            obj.auth = gui_val(4)+":"+gui_val(5)
            
        case "ubidots"
            
            params = ["Variable ID","Token ID"] 
            default = ["",""]
            message = ["Please input the following parameters."]
            gui_val = x_mdialog(message,params,default)
            
            obj.variableid = gui_val(1)
            obj.post_acc = gui_val(2)
            obj.read_acc = gui_val(2)
            
        case "favoriot"
            
            params = ["Device Developer ID","User API"] 
            default = ["",""]
            message = ["Please input the following parameters."]
            gui_val = x_mdialog(message,params,default)
            
            obj.deviceid = gui_val(1)
            obj.post_acc = gui_val(2)
            obj.read_acc = gui_val(2)
            
        case "thingspeak"
            
            params = ["Channel ID","Channel Write Key","Channel Read Key"] 
            default = ["","",""]
            message = ["Please input the following parameters."]
            gui_val = x_mdialog(message,params,default)
            
            obj.deviceid = gui_val(1)
            obj.post_acc = gui_val(2)
            obj.read_acc = gui_val(3)
            
        else
            error(msprintf("The specified cloud %s is not supported.\n",cloud))
        end
        
        
        
    else
        // Check arguments
        args = length(varargin)
        if floor(args/2)*2<>args then
            error(msprintf("Arguments need to be in key-value pairs.\n"));
        end
        
        // for general input
       for i =1:2:args
           select convstr(varargin(i))
           case "url"
               obj.url_base = varargin(i+1)
           case "deviceid"
               obj.deviceid = varargin(i+1)
           case "post_acc"
               obj.post_acc = varargin(i+1)
           case "read_acc"
               obj.read_acc = varargin(i+1)
           case "auth"
               obj.auth = varargin(i+1)
           case "token"
               obj.token = varargin(i+1)
           case "variableid"
               obj.variableid = varargin(i+1)
           case "channelid"
               obj.deviceid = varargin(i+1)
           else
               error(msprintf("Wrong options.\n"))
           end
       end       
        
    end
    
    
   
   
   
   // For specific configuration unique to cloud
   select convstr(cloud)
   case "thingsboard"
       
       // Assign base url if none given
       if obj.url_base == ""
           obj.url_base = "https://demo.thingsboard.io"
       end
       
       // Thingsboard Post URL 
       obj.url_post = obj.url_base+"/api/v1/"+obj.post_acc+"/telemetry"
       
       // Thingsboard Get URL
       obj.url_get = obj.url_base+"/api/plugins/telemetry/DEVICE/"+obj.deviceid+"/values/timeseries?keys="
       
       // Thingsboard Token
       if obj.token == "" then // get token from auth
           if obj.auth ~= "" then
               temp = strsplit(obj.auth,":")
               temptoken = thingsboard_getToken(obj.url_base,temp(1),temp(2))
               obj.token = temptoken.token
           else
               error(msprintf("Authentication or token needed for Thingsboard.\n"))
           end
       end // end of check token
   case "ubidots"
       
       // Assign base url if none given
       if obj.url_base == ""
           obj.url_base = "http://things.ubidots.com/api/v1.6" 
       end
       
       // Ubidots Post URL
       obj.url_post = obj.url_base+"/variables/"+obj.variableid+"/values/?token="+obj.post_acc
       
       // Ubidots Get URL
       obj.url_get = obj.url_base+"/variables/" + obj.variableid + '/values?token=' + obj.post_acc
       
       
   case "thingspeak"
       
       // Assign base url if none given
       if obj.url_base == ""
            obj.url_base = "https://api.thingspeak.com"
       end
       
       // Thingspeak Post URL
       obj.url_post = obj.url_base+"/update.json?api_key="+obj.post_acc
       
       // Thingspeak Get URL
       obj.url_get = obj.url_base+"/channels/"+string(obj.deviceid)+"/fields/_FIELDNBR_.json?api_key="+obj.read_acc
       
       
   case "favoriot"
       
       // Assign base url if none given
       if obj.url_base == ""
           obj.url_base = "https://apiv2.favoriot.com/v2"
       end
       
       // Favoriot Post URL
       obj.url_post = obj.url_base + "/streams"
       
       // Favoriot Get URL
       obj.url_get = obj.url_base+"/streams?device_developer_id="+obj.deviceid
       
   else
       error(msprintf("The specified cloud %s is not supported.\n",cloud))
   end // end of select cloud
    
endfunction
