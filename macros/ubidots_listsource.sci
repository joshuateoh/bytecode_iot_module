function [num_ds,ds_name, ds_id,num_var,out] = ubidots_listsource(tokenID)
// List the source available in Ubidots account
//
// Syntax
//    [num_ds,ds_name, ds_id,num_var,out] = ubidots_listsource(tokenID)
//
// Parameters
//     tokenID : Token ID
//     num_ds : Number of sources available
//     ds_name : Data sources name
//     ds_id : Data sources ID
//     num_var : Numbers of variables available in each source
//     out : Structure of full details, always not required
//
// Description
//     List the source available in Ubidots account and return the information of them.
//    
// See also
//    ubidots_get
//    ubidots_getdata
//    ubidots_listvar
//    ubidots_post
//
// Authors
//     C.L. Tan, Bytecode    
//        
    baseurl = "http://things.ubidots.com/api/v1.6/";
    listsource = baseurl + 'datasources?token=' + tokenID;
    [a2,b2] = getURL(listsource);
    out=JSONParse(b2);
    num_ds = out.count;
    ds_name = list2vec(out.results.name);
    ds_id = list2vec(out.results.id);
    num_var = list2vec(out.results.number_of_variables);
    
    mprintf('Data Source Summary\n');
    mprintf('-------------------\n\n');
    mprintf('Number of Sources \t : %d\n', num_ds);
    mprintf('Sources Name \t\t : ');
    mprintf('%s\t',ds_name);
    mprintf('\n');
    mprintf('Sources ID \t\t : ');    
    mprintf('%s\t',ds_id);  
    mprintf('\n');
    mprintf('Number of Vars \t\t : ');  
    mprintf('%d\t', num_var);
    mprintf('\n');
    
//    for cnt = 1:num_ds
//        mprintf('%s\t', ds_name());
//    end
//    
    

       
endfunction
