function fl = filterFILE(url_ip, needle)
// Get the file list filtered by extension from a file server
//
// Syntax
//     fl = filterFILE(url_ip, needle)
//
// Parameters
//     url_ip : File server IP address
//     needle : Keyword to search
//     fl : File list
//
// Description
//    This is to get the file list from a file server, by given keyword
//    
// Examples
//     url_ip = "http://<somefileserver>"
//     fl = filterFILE(url_ip,'.sce')
//
// See also
//      getFILE
//
// Authors
//     C.L. Tan, Bytecode
// 
    [fn, contents] = getURL(url_ip,TMPDIR);
    doc = htmlRead(fn);
    all_str = doc.root.content;
    ind = grep(all_str,needle);
    filtered_file = all_str(ind);
    filtered_file = stripblanks(filtered_file,%t)
    fl = strsubst(filtered_file,ascii(13),'')


endfunction
