function [rep,stat,stderr] = postURL(url,varargin)
// Post command for curl library
//
// Syntax
//     [rep,stat,stderr] = postURL(url,cmd)
//
// Parameters
//     url : A valid URL
//     cmd : Post command to the site
//     rep : Response
//     stat : Message
//     stderr : Error Message
//
// Description
//    This is to POST the request to a supported website
//    
//
// See also
//
// Authors
//     C.L. Tan, Bytecode
// 

//curl_loc = SCI + '\tools\curl\curl';
//post_cmd = ' -d ';
//[rep,stat,stderr] = unix_g(curl_loc + post_cmd + """" + cmd + """ "  + url);
//


ListArg = varargin;
[OS,Version]=getos();
if OS == 'Windows' then
    curl_loc = SCI + '\tools\curl\curl';
else
    curl_loc = 'curl';
end

// post_cmd = ' -d ';

sz = size(ListArg);

cmd = curl_loc; 

for cnt = 1:2:sz
    cmd = cmd + ' ' + ListArg(cnt) + ' ' + ListArg(cnt+1);
end

cmd = cmd + ' ' + url;

[rep,stat,stderr] = unix_g(cmd);


endfunction



