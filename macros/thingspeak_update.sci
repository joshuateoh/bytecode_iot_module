function entryID=thingspeak_update(channelID,privacy,datastruct,apiWriteKey,apiReadKey)
// Update a Thingspeak Channel
//
// Syntax
//     entryID=thingspeak_update(channelID,privacy,datastruct,apiWriteKey,apiReadKey)
//
// Parameters
//     channelID : ID of the channel in ThingSpeak
//     privacy : Specify whether the channel is 'public' or 'private'
//     datastruct : The data structure created using thingspeak_newentry
//     apiWriteKey : Write API Key of the channel. The Write Key can be used as the Read API Key as well.
//     apiReadKey : Read API Key of the channel. 
//     entryID : The entry ID
//
// Description
//    Updates a ThingSpeak channel using the data structure created by thingspeak_newentry.
//    
// Examples
//    new_entry = thingspeak_newentry("status","New update!","field1",20)
//    entry_update = thingspeak_update(channelID,'private',new_entry,"writekey","")
//    get_entry = thingspeak_fieldvalues(channelID,'private',"","readkey",1,"results",1,"status",%t)
// 
// See also
//     thingspeak_channelinfo
//     thingspeak_fieldvalues
//     thingspeak_newentry
//     thingspeak_plot
//
// Authors
//     Joshua T., Bytecode

    jimport com.angryelectron.thingspeak.Channel
    jimport com.angryelectron.thingspeak.Entry

    // Create a channel
    if convstr(privacy) == 'public' then
        channel = jnewInstance(Channel,channelID, apiWriteKey)
    elseif convstr(privacy) == 'private' then
        if apiReadKey == ''
            channel = jnewInstance(Channel,channelID, apiWriteKey,apiWriteKey)
        else
             channel = jnewInstance(Channel,channelID, apiWriteKey,apiReadKey)
        end
    end
    // Create an Entry object and set the values
    entry = jnewInstance(Entry)
    entry.setField(1,string(datastruct.field1))
    entry.setField(2,string(datastruct.field2))
    entry.setField(3,string(datastruct.field3))
    entry.setField(4,string(datastruct.field4))
    entry.setField(5,string(datastruct.field5))
    entry.setField(6,string(datastruct.field6))
    entry.setField(7,string(datastruct.field7))
    entry.setField(8,string(datastruct.field8))
    entry.setLong(datastruct.longitude)
    entry.setLatitude(datastruct.latitude)
    entry.setElevation(datastruct.elevation)
    entry.setStatus(string(datastruct.status))
    // Update the channel
    entryID = channel.update(entry)
    
endfunction
