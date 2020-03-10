function [num_var,var_name,var_id,out] = ubidots_listvar(tokenID, dsID)
// List the variables available in Ubidots source
//
// Syntax
//    [num_var,var_name,var_id,out] = ubidots_listvar(tokenID, dsID)
//
// Parameters
//     tokenID : Token ID
//     dsID : Data source ID
//     num_var : Number of varibles available
//     var_name : Variables name
//     var_id : Variables ID
//     out : Structure of full details, always not required
//
// Description
//    List the variables available in Ubidots source and return the information of them.
//    
// See also
//    ubidots_get
//    ubidots_getdata
//    ubidots_listsource
//    ubidots_post
//
// Authors
//     C.L. Tan, Bytecode   
//    
    baseurl = "http://things.ubidots.com/api/v1.6/";
    listvar = baseurl + 'datasources/' + dsID + '/variables?token=' + tokenID;
    //listvar="http://things.ubidots.com/api/v1.6/datasources/5701e054762542415b9d2eff/variables?token=unDZ22XSXmJeCz1HU8pHy5aoRYKjEq";
    [a3,b3]=getURL(listvar);
    out=fromJSON(b3);
    num_var = out.count;
    var_name = list2vec(out.results.name);
    var_id = list2vec(out.results.id);
    

    
    mprintf('Variable(s) Summary\n');
    mprintf('-------------------\n\n');
    mprintf('Number of Variable(s)\t : %d\n', num_var);
    mprintf('Variable(s) Name \t : ');
    mprintf('%s\t',var_name);
    mprintf('\n');
    mprintf('Variable(s) ID \t\t : ');    
    mprintf('%s\t',var_id);  
    mprintf('\n');

        
endfunction
