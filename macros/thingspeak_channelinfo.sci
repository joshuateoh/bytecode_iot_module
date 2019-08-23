function channel_info= thingspeak_channelinfo(channelID,privacy,apiWriteKey,apiReadKey)
// Get Thingspeak Channel Information
//
// Syntax
//     channel_info= thingspeak_channelinfo(channelID,privacy,apiWriteKey,apiReadKey)
//
// Parameters
//     channelID : channel ID in ThingSpeak
//     privacy : Specify whether the channel is 'public' or 'private'
//     apiWriteKey : Write API Key of the channel
//     apiReadKey : Read API Key of the channel. 
//     channel_info : Channel information
//
// Description
//    This is to display the information of the channel in the thingspeak cloud.
//    
// Examples
//    channel_info= thingspeak_channelinfo(channelID,"private","writekey","readkey")
// 
// See also
//     thingspeak_fieldvalues
//     thingspeak_newentry
//     thingspeak_plot
//     thingspeak_update
//
// Authors
//     Joshua T., Bytecode

    jimport com.angryelectron.thingspeak.Channel

    // Create the channel object
    if convstr(privacy) == 'public' then
        channel = jnewInstance(Channel,channelID, apiWriteKey)
    elseif convstr(privacy) == 'private' then
        if apiReadKey == ''
            channel = jnewInstance(Channel,channelID, apiWriteKey,apiWriteKey)
        else
             channel = jnewInstance(Channel,channelID, apiWriteKey,apiReadKey)
        end
    end
    // Obtain the channel feed and extract information from it
    channelfeed = jinvoke(channel,'getChannelFeed')
    channelid = jinvoke(channelfeed,'getChannelId');
    channeldate = jinvoke(channelfeed,'getChannelCreationDate');
    channeldatestr = jinvoke(channeldate,'toString');
    lastupdate = jinvoke(channelfeed,'getChannelUpdateDate');
    lastupdatestr = jinvoke(lastupdate,'toString');
    
    // Place the information inside a structure
    channel_info = struct("channelname",jinvoke(channelfeed,'getChannelName'), ..
                "description",jinvoke(channelfeed,'getChannelDescription'), ..
                "id",double(channelid), ..
                "creationdate",channeldatestr, ..
                "lastupdate",lastupdatestr )                    
    
endfunction
