function fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiReadKey,fieldnbr,varargin)
// Find (GET) values from a field in a ThingSpeak channel
//
// Syntax
//     fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiReadKey,fieldnbr)
//     fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiReadKey,fieldnbr,optionName,optionValues)
//
// Parameters
//     channelID : ID of the channel in ThingSpeak
//     privacy : Specify whether the channel is 'public' or 'private'
//     apiReadKey : Read API Key of the channel (required for private channels)
//     fieldnbr : The field number to retrieve the data from (1-8)
//     optionName, optionValues : Additional options on how to retrieve the field values
//                  
//     fieldvalues : Return the field's values
//
// Description
//    This function is used to get values from the thingspeak channel. The additional options are:
//
// results : number of values to retrieve
//
// days : retrieve values up to x number of days
//
// min : minimum values to retrieve
//
// max : maximum value to retrieve
//
// sum : sum of values in time intervals
//
// average : average values in time intervals
//
// median : median values in time intervals
//
// timescale : first value for each time interval
//
// startdate : Retrieve the values starting from the given date. The format is "yyyy-MM-dd HH:mm:ss". The default timezone for the date is UTC. You can change the timezone using the 'offset' option. 
//    
// enddate : Retrieve the values up to the given date. The format is "yyyy-MM-dd HH:mm:ss". The default timezone for the date is UTC. You can change the timezone using the 'offset' option.
//
// offset : Change the timezone used by 'startdate' and 'enddate' options.
//
// status : Boolean input on whether to include status for each entry.
//
// location : Boolean input on whether to include the location (latitude, longitude,elevation) for each entry.
//
// The allowed time intervals for sum, median, average and timescale are 10, 15, 20, 30, 60, 240, 720 and 1440 minutes.
//
// Examples
//    fv1=thingspeak_fieldvalues(channelID,'private','','readkey',1) //  By default, retrieve entries entered within the last 24 hours
//    fv2=thingspeak_fieldvalues(channelID,'private','','readkey',1,'results',5) // Get the last 5 entries
//    fv3=thingspeak_fieldvalues(channelID,'private','','readkey',1,'days',10,'min',4) // Get from the last 10 days, entries with minimum value of 4
//    fv4=thingspeak_fieldvalues(channelID,'private','','readkey',1,'startdate',"2015-05-12 8:25:00") // Get values starting from 2015-05-12 8:25:00 (UTC)
//    fv5=thingspeak_fieldvalues(channelID,'private','','readkey',1,'startdate',"2015-05-12 8:25:00","offset",8) // Get values starting from 2015-05-12 8:25:00 (+8 GMT)
//    fv6=thingspeak_fieldvalues(channelID,'private','','readkey',1,'results',10,'status',%t,'location',%t) // Include the status and location fields
//
// See also
//     thingspeak_channelinfo
//     thingspeak_newentry
//     thingspeak_plot
//     thingspeak_update

//
// Authors
//     Joshua T., Bytecode

    sym1 = "?";
    acceptable_period = ['10','15','20','30','60','240','720','1440','daily']
    
    if fieldnbr > 8 then
        error(msprintf("Wrong field number. (1-8) \n"));
    end

    // Create the channel
    url_base = "https://api.thingspeak.com/channels/"+string(channelID)+"/fields/"+string(fieldnbr)+".json"
    if convstr(privacy) == 'public' then
        sym1 = "?"
        
    elseif convstr(privacy) == 'private' then
        url_base = url_base+"?api_key="+apiReadKey
        sym1 = "&"
    else
        error(msprintf("Wrong privacy input. ''public'' or ''private''\n"))
    end
    
    addstatus = %f
    addlocation = %f
    
    // Check the number of optional arguments
    rhs = length(varargin)
    if floor(rhs/2)*2<>rhs then
        error(msprintf("Wrong number of optional input argument(s) : an even number is expected.\n"));
    end
    
    opt_arg = ""
    // Go through the optional arguments
    if rhs >=2 then
        for i =1:2:rhs
            
            if i ~= 1 then
                sym1 = "&"
            end
            
            select convstr(varargin(i))
            case "results"
                opt_arg = opt_arg + sym1 + "results="+string(varargin(i+1)) 
            case "days"
                opt_arg = opt_arg + sym1 + "days="+string(varargin(i+1))    
            case "min"
                opt_arg = opt_arg + sym1 + "min="+string(varargin(i+1)) 
            case "max"
                opt_arg = opt_arg + sym1 + "max="+string(varargin(i+1))
            case "sum"
                chk = grep(acceptable_period,string(varargin(i+1)))
                if chk == []
                    error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes or ""daily"".\n"))
                else
                     opt_arg = opt_arg + sym1 + "sum="+string(varargin(i+1))
                end
            case "average"
                chk = grep(acceptable_period,string(varargin(i+1)))
                if chk == []
                    error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes or ""daily"".\n"))
                else
                     opt_arg = opt_arg + sym1 + "average="+string(varargin(i+1))
                end
            case "median"
                chk = grep(acceptable_period,string(varargin(i+1)))
                if chk == []
                    error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes or ""daily"".\n"))
                else
                     opt_arg = opt_arg + sym1 + "median="+string(varargin(i+1))
                end
            case "timescale"
                chk = grep(acceptable_period,string(varargin(i+1)))
                if chk == []
                    error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes or ""daily"".\n"))
                else
                     opt_arg = opt_arg + sym1 + "timescale="+string(varargin(i+1))
                end
            case "startdate"
                datestr = varargin(i+1);
                datestr = strsubst(datestr," ","%20")
                opt_arg = opt_arg + sym1 + "start="+datestr
            case "enddate"
                datestr = varargin(i+1);
                datestr = strsubst(datestr," ","%20")
                opt_arg = opt_arg + sym1 + "end="+datestr
            case "offset"
                opt_arg = opt_arg + sym1 + "offset="+string(varargin(i+1))
            case "status"
                if or(type(varargin(i+1))==[4,6])
                    addstatus = varargin(i+1)
                    if addstatus == %t
                        opt_arg = opt_arg + sym1 + "status=true"
                    end
                else
                    error(msprintf("Status input must be boolean.\n"))
                end
            case "location"
                if or(type(varargin(i+1))==[4,6])
                    addlocation = varargin(i+1);
                    if addlocation == %t
                        opt_arg = opt_arg + sym1 + "location=true"
                    end
                else
                    error(msprintf("Location input must be boolean.\n"))
                end
            else
                error(msprintf("Wrong options.\n"))
            end
        end        
    end
    
    url_str = url_base + opt_arg
    [result, status] = http_get(url_str)
    
    feed = result.feeds;
    field = "field"+string(fieldnbr)
    
    if isfield(feed,field) then
        
        select field
        case "field1"
            values = list2vec(feed.field1)
        case "field2"
            values = list2vec(feed.field2)
        case "field3"
            values = list2vec(feed.field3)
        case "field4"
            values = list2vec(feed.field4)
        case "field5"
            values = list2vec(feed.field5)
        case "field6"
            values = list2vec(feed.field6)
        case "field7"
            values = list2vec(feed.field7)
        case "field8"
            values = list2vec(feed.field8)
        end
        
        time = list2vec(feed.created_at) 
        fieldvalues=struct("values",values,"time",time)
        
        if addstatus == %t
            fieldvalues.status = list2vec(feed.status)
        end
        
        if addlocation == %t
            fieldvalues.latitude = list2vec(feed.latitude)
            fieldvalues.longitude = list2vec(feed.longitude)
            fieldvalues.elevation = list2vec(feed.elevation)
        end
        
    else
        fieldvalues=[]
    end
    
    
endfunction
