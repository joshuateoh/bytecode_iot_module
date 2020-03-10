function entryID=thingspeak_update(apiWriteKey,datastruct)
// Update a Thingspeak Channel
//
// Syntax
//     entryID=thingspeak_update(apiWriteKey,datastruct)
//
// Parameters
//     apiWriteKey : Write API Key of the channel.
//     datastruct : The data structure created using thingspeak_newentry
//     entryID : The entry ID
//
// Description
//    Updates a ThingSpeak channel using the data structure created by thingspeak_newentry.
//    
// Examples
//    new_entry = thingspeak_newentry("status","New update!","field1",20)
//    entry_update = thingspeak_update("writekey",new_entry)
// 
// See also
//     thingspeak_channelinfo
//     thingspeak_fieldvalues
//     thingspeak_newentry
//     thingspeak_plot
//
// Authors
//     Joshua T., Bytecode

    url_base = "https://api.thingspeak.com/update.json?api_key="+apiWriteKey
    
    update = "";
    if datastruct.field1 ~= [] then
        update = update + "&field1=" + string(datastruct.field1)
    end
    if datastruct.field2 ~= [] then
        update = update + "&field2=" + string(datastruct.field2)
    end
    if datastruct.field3 ~= [] then
        update = update + "&field3=" + string(datastruct.field3)
    end
    if datastruct.field4 ~= [] then
        update = update + "&field4=" + string(datastruct.field4)
    end
    if datastruct.field5 ~= [] then
        update = update + "&field5=" + string(datastruct.field5)
    end
    if datastruct.field6 ~= [] then
        update = update + "&field6=" + string(datastruct.field6)
    end
    if datastruct.field7 ~= [] then
        update = update + "&field7=" + string(datastruct.field7)
    end
    if datastruct.field8 ~= [] then
        update = update + "&field8=" + string(datastruct.field8)
    end
    if datastruct.longitude ~= [] then
        update = update + "&long=" + string(datastruct.longitude)
    end
    if datastruct.latitude ~= [] then
        update = update + "&lat=" + string(datastruct.latitude)
    end
    if datastruct.elevation ~= [] then
        update = update + "&elevation=" + string(datastruct.elevation)
    end
    if datastruct.status ~= [] then
        update = update + "&status=" + string(datastruct.status)
    end
    
    url_str = url_base + update
    [result, status] = http_get(url_str)
    entryID = result.entry_id
    
endfunction
