function [fn, contents] = getFILE(url_ip, filename)
// Download the files given in filename from a file server
//
// Syntax
//     [fn, contents] = getFILE(url_ip, filename)
//
// Parameters
//     url_ip : File server IP address
//     filename : File names for the files to be downloaded
//     fn : Last filename downloaded
//     contents : Last contents of the file downloaded
//
// Description
//    This is to download the files from a file server, by given filenames in a string vector 
//    
// Examples
//     url_ip = "http://<somefileserver>"
//     fl = filterFILE(url_ip,'.sce')
//     [fn, contents] = getFILE(url_ip, fl)
//
// See also
//      filterFILE
//
// Authors
//     C.L. Tan, Bytecode
//     

    for cnt = 1:size(filename,'*')
        [fn, contents] = getURL(url_ip+'/'+filename(cnt));
    end
    
endfunction
