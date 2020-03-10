function channel_info= thingspeak_channelinfo(channelID,userapi)
// Get Thingspeak Channel Information
//
// Syntax
//     channel_info= thingspeak_channelinfo(channelID,privacy,apiWriteKey,apiReadKey)
//
// Parameters
//     channelID : channel ID in ThingSpeak
//     userapi : User account api (required for private channels)
//     channel_info : Channel information
//
// Description
//    This is to display the information of the channel in the thingspeak cloud.
//    
// Examples
//    channel_info= thingspeak_channelinfo(channelID,"userapi")
// 
// See also
//     thingspeak_fieldvalues
//     thingspeak_newentry
//     thingspeak_plot
//     thingspeak_update
//
// Authors
//     Joshua T., Bytecode

    rhs = argn(2)

    if rhs == 1 then
        url_str = "http://api.thingspeak.com/channels/"+string(channelID)+".json"
    else        
        url_str = "http://api.thingspeak.com/channels/"+string(channelID)+".json?api_key="+userapi
    end

    
    [channel_info, status] = http_get(url_str)
    
endfunction
