function task = bg_run(fn)
//  Run a Scilab script at background
//
// Syntax
//     task = bg_run(fn)
//
// Parameters
//     fn : Scilab script name in string format
//     task : Process ID for the task
//
// Description
//    This is to sent the Scilab task to the background as silent process
//    
// Examples
//    task = bg_run('myscript.sce')
//    
// See also
//     bg_display
//     bg_terminate
//
// Authors
//     C.L. Tan, Bytecode

    [OS, Version] = getos()
    if OS == 'Windows' then


        unix('start /b '+SCI+'\bin\scilex -f ' + fn);
        all_process = unix_g('tasklist /FI ""IMAGENAME eq Scilex.exe"" /FO TABLE /NH');
        current_process = all_process($);
        temp = tokens(current_process);
        task = strtod(temp(2));
        mprintf('Program Running at Background \n');
        mprintf('========================== \n');
        mprintf('Program Name \t: %s.\n',fn);
        mprintf('PID \t\t: %i \n',task);
        mprintf('Use bg_terminate(pid) to kill the process\n');

    else
        unix_g(SCI+'/../../bin/scilab-adv-cli -f ' + fn + ' &');
        all_process = unix_g('ps -e | grep scilab');
        ind = grep(all_process,'scilab-adv-cli');
        current_process = all_process(ind($)+1);
        temp = tokens(current_process);
        task = strtod(temp(1));
        mprintf('Program Running at Background \n');
        mprintf('========================== \n');
        mprintf('Program Name \t: %s.\n',fn);
        mprintf('PID \t\t: %i \n',task);
        mprintf('Use bg_terminate(pid) to kill the process\n');        
        
    end
    // unix_g('taskkill /F /PID 4888')
endfunction
