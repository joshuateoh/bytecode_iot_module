function fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiWriteKey,apiReadKey,fieldnbr,varargin)
// Find (GET) values from a field in a ThingSpeak channel
//
// Syntax
//     fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiWriteKey,apiReadKey,fieldnbr)
//     fieldvalues=thingspeak_fieldvalues(channelID,privacy,apiWriteKey,apiReadKey,fieldnbr,optionName,optionValues)
//
// Parameters
//     channelID : ID of the channel in ThingSpeak
//     privacy : Specify whether the channel is 'public' or 'private'
//     apiWriteKey : Write API Key of the channel
//     apiReadKey : Read API Key of the channel
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

    jimport com.angryelectron.thingspeak.Channel
    jimport com.angryelectron.thingspeak.FeedParameters
    jimport java.text.SimpleDateFormat

    // Create the channel
    if convstr(privacy) == 'public' then
        channel = jnewInstance(Channel,channelID, apiWriteKey)
    elseif convstr(privacy) == 'private' then
        if apiReadKey == ''
            channel = jnewInstance(Channel,channelID, apiWriteKey,apiWriteKey)
        else
             channel = jnewInstance(Channel,channelID, apiWriteKey,apiReadKey)
        end
    else
        error(msprintf("Wrong privacy input. ''public'' or ''private''\n"))
    end
    
    options = jnewInstance(FeedParameters);
    dateformatter = jnewInstance(SimpleDateFormat,"yyyy-MM-dd HH:mm:ss");
    addstatus = %f
    addlocation = %f
    
    // Check the number of optional arguments
    rhs = length(varargin)
    if floor(rhs/2)*2<>rhs then
        error(msprintf("Wrong number of optional input argument(s) : an even number is expected.\n"));
    end
        
    // Go through the optional arguments
    if rhs >=2 then
        for i =1:2:rhs
                select convstr(varargin(i))
                case "results"
                    options.results(varargin(i+1));
                case "days"
                    options.days(varargin(i+1));
                case "min"
                    options.min(varargin(i+1));
                case "max"
                    options.max(varargin(i+1));
                case "sum"
                    select varargin(i+1)
                    case 10
                        options.sum(FeedParameters$Period.T10m);
                    case 15
                        options.sum(FeedParameters$Period.T15m);
                    case 20
                        options.sum(FeedParameters$Period.T20m);
                    case 30
                        options.sum(FeedParameters$Period.T30m);
                    case 60
                        options.sum(FeedParameters$Period.T1h);
                    case 240 // 4 hours
                        options.sum(FeedParameters$Period.T4h);
                    case 720 //12 hours
                        options.sum(FeedParameters$Period.T12h);
                    case 1440
                        options.sum(FeedParameters$Period.T24h);
                    else
                        error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes.\n"))
                    end
                case "average"
                    select varargin(i+1)
                    case 10
                        options.average(FeedParameters$Period.T10m);
                    case 15
                        options.average(FeedParameters$Period.T15m);
                    case 20
                        options.average(FeedParameters$Period.T20m);
                    case 30
                        options.average(FeedParameters$Period.T30m);
                    case 60
                        options.average(FeedParameters$Period.T1h);
                    case 240 // 4 hours
                        options.average(FeedParameters$Period.T4h);
                    case 720 //12 hours
                        options.average(FeedParameters$Period.T12h);
                    case 1440
                        options.average(FeedParameters$Period.T24h);
                    else
                        error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes.\n"))
                    end
                case "median"
                    select varargin(i+1)
                    case 10
                        options.median(FeedParameters$Period.T10m);
                    case 15
                        options.median(FeedParameters$Period.T15m);
                    case 20
                        options.median(FeedParameters$Period.T20m);
                    case 30
                        options.median(FeedParameters$Period.T30m);
                    case 60
                        options.median(FeedParameters$Period.T1h);
                    case 240 // 4 hours
                        options.median(FeedParameters$Period.T4h);
                    case 720 //12 hours
                        options.median(FeedParameters$Period.T12h);
                    case 1440
                        options.median(FeedParameters$Period.T24h);
                    else
                        error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes.\n"))
                    end
                case "timescale"
                    select varargin(i+1)
                    case 10
                        options.timescale(FeedParameters$Period.T10m);
                    case 15
                        options.timescale(FeedParameters$Period.T15m);
                    case 20
                        options.timescale(FeedParameters$Period.T20m);
                    case 30
                        options.timescale(FeedParameters$Period.T30m);
                    case 60
                        options.timescale(FeedParameters$Period.T1h);
                    case 240 // 4 hours
                        options.timescale(FeedParameters$Period.T4h);
                    case 720 //12 hours
                        options.timescale(FeedParameters$Period.T12h);
                    case 1440 // 24 hours
                        options.timescale(FeedParameters$Period.T24h);
                    else
                        error(msprintf("Wrong time range. \nPermitted time range is 10,15,20,30,60,240,720,1440 minutes.\n"))
                    end
                case "startdate"
                    startdate = dateformatter.parse(varargin(i+1));
                    options.start(startdate);
                case "enddate"
                    enddate = dateformatter.parse(varargin(i+1));
                    options.end(enddate);
                case "offset"
                    options.offset(varargin(i+1));
                case "status"
                    if or(type(varargin(i+1))==[4,6])
                        options.status(varargin(i+1));
                        addstatus = varargin(i+1)
                    else
                        error(msprintf("Status input must be boolean.\n"))
                    end
                case "location"
                    if or(type(varargin(i+1))==[4,6])
                        options.location(varargin(i+1));
                        addlocation = varargin(i+1);
                    else
                        error(msprintf("Location input must be boolean.\n"))
                    end
                else
                    error(msprintf("Wrong options.\n"))
                end
        end        
    end
    
    // Obtain the channel feed using the options given
    channelfeed = jinvoke(channel,'getChannelFeed',options)
    // Grab the feed's entries
    entrylist = jinvoke(channelfeed,'getEntryList');
    
    if fieldnbr > 8 then
        error(msprintf("Wrong field number. (1-8) \n"));
    end
    
    if jinvoke(entrylist,'size') == 0 then
        // No entries found. 
        fieldvalues=[]
    else // Go thru each entry
        for i = 1:jinvoke(entrylist,'size')
            entry_itr = entrylist(i)
            values(i) = jinvoke(entry_itr,'getField',fieldnbr)
            time(i) = jinvoke(jinvoke(entry_itr,'getCreated'),'toString')
            if addstatus == %t
                cur_stat = jinvoke(entry_itr,'getStatus')
                if cur_stat == []
                    status(i) = ""
                else
                    status(i) = cur_stat;
                end
            end
            if addlocation == %t
                cur_lat = jinvoke(entry_itr,'getLatitude')
                cur_long = jinvoke(entry_itr,'getLongitude')
                cur_elev = jinvoke(entry_itr,'getElevation')
                latitude(i) = cur_lat
                longitude(i) = cur_long
                elevation(i) = cur_elev
            end
        end
        
        if addstatus == %t
            if addlocation == %t
                fieldvalues=struct("values",values,"time",time,"status",status,"latitude",latitude,"longitude",longitude,"elevation",elevation)
            else
                fieldvalues=struct("values",values,"time",time,"status",status)
            end
        else
            if addlocation == %t
                fieldvalues=struct("values",values,"time",time,"latitude",latitude,"longitude",longitude,"elevation",elevation)
            else
                fieldvalues=struct("values",values,"time",time)
            end
        end
    end
    
endfunction
