function bg_display()
// Display list of Scilab processes run at background
//
// Syntax
//     bg_display()
//
// Parameters
//
// Description
//    This is to display the list of Scilab background processes run by using bg_run
//    
// Examples
//    bg_display()
//    
// See also
//     bg_run
//     bg_terminate
//
// Authors
//     C.L. Tan, Bytecode

    [OS, Version] = getos()
    if OS == 'Windows' then

        unix_w('tasklist /FI ""IMAGENAME eq Scilex.exe"" /FO TABLE');
    else
        all_process = unix_g('ps -e | grep scilab');
        ind = grep(all_process,'scilab-adv-cli');        


        mprintf('Program Running at Background \n');
        mprintf('========================== \n');

        for cnt = 1:size(ind,2)
            current_process = all_process(ind(cnt)+1);
            temp = tokens(current_process);
            task = strtod(temp(1));
            mprintf('PID \t\t: %i \n',task);
            mprintf('Use bg_terminate(pid) to kill the process\n');      
        end

        //mprintf('Program Name \t: %s.\n',fn);


    end



endfunction
