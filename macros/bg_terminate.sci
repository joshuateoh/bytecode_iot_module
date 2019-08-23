function bg_terminate(pid)
//  Terminate a Scilab background process
//
// Syntax
//    bg_terminate(pid)
//
// Parameters
//     pid : Process ID for the task
//
// Description
//    This is to sent the Scilab task to the background as silent process
//    
// Examples
//    bg_terminate(pid)
//    
// See also
//     bg_display
//     bg_run
//
// Authors
//     C.L. Tan, Bytecode

    [OS, Version] = getos()
    if OS == 'Windows' then

        out = unix_g('taskkill /F /PID ' + string(pid));
    else
        out = unix_g('kill ' + string(pid));
    end
    disp(out);
endfunction
