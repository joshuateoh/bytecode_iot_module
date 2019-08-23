function newentry=thingspeak_newentry(varargin)
//    Create a structure to store the data that is to be sent to the ThingSpeak channel.
//
// Syntax
//     new_entry=thingspeak_newentry(FieldName,FieldValue)
//
// Parameters
//     FieldName : The field names (field1,..,field8,latitude,longitude,elevation,status)
//     FieldValue : The data to be stored
//     new_entry : The data structure
//
// Description
//    This function creates a data structure to store the data that is to be sent to a ThingSpeak channel. 
//    The data structure is sent using thingspeak_update.
// 
// Examples
//    new_entry = thingspeak_newentry("status","New update!","field1",25)
//    entry_update = thingspeak_update(channelID,'private',new_entry,"writekey","")
//    get_entry = thingspeak_fieldvalues(channelID,'private',"","readkey",1,"results",1,"status",%t)
// 
// See also
//     thingspeak_channelinfo
//     thingspeak_fieldvalues
//     thingspeak_plot
//     thingspeak_update
//
// Authors
//     Joshua T., Bytecode
    
    // Check correct number of arguments
    rhs=argn(2)
    
    if floor(rhs/2)*2<>rhs then
        error(msprintf("Wrong number of input argument(s) : an even number is expected.\n"));
    end
    
    // Create blank structure
    newentry = struct("field1",[],"field2",[],"field3",[],"field4",[],"field5",[],"field6",[],"field7",[],"field8",[],"latitude",[],"longitude",[],"elevation",[],"status",[])
    
    // Fill in the structure
    if rhs == 0 then
        // do nothing
    else
        for i =1:2:rhs
            select convstr(varargin(i))
            case "field1"
                newentry.field1 = varargin(i+1)
            case "field2"
                newentry.field2 = varargin(i+1)
            case "field3"
                newentry.field3 = varargin(i+1)
            case "field4"
                newentry.field4 = varargin(i+1)
            case "field5"
                newentry.field5 = varargin(i+1)
            case "field6"
                newentry.field6 = varargin(i+1)
            case "field7"
                newentry.field7 = varargin(i+1)
            case "field8"
                newentry.field8 = varargin(i+1)
            case "latitude"
                newentry.latitude = varargin(i+1)
            case "longitude"
                newentry.longitude =varargin(i+1)
            case "elevation"
                newentry.elevation = varargin(i+1)
            case "status"
                newentry.status = varargin(i+1)
            else
                error(msprintf("Wrong field name (field1,field2,...,field8,latitude,longitude,elevation,status)\n"))
            end
        end
    end
    
endfunction
