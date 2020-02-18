function tb = xmlScanAllTable(doc)
    //  Import All xml/html Tables into Scilab
    //
    // Syntax
    //     tb = xmlScanAllTable(doc)
    //
    // Parameters
    //     doc : An xml document which is obtained from htmlRead
    //     tb : Return tables in string list
    //
    // Description
    //    This function used to extract all xml/html tables and return it to the Scilab as string list.
    //    
    //    
    // See also
    //     xmlScanTable
    //
    // Authors
    //     C.L. Tan, Bytecode

    rhs=argn(2);
    lines(0);
    // Error Checking
    if rhs < 1; error("Expect at least 1 argument, doc"); end    
    //if rhs < 3; with_header = %t; end

    xp = xmlXPath(doc, '//table');
    tb_no = xp.size;
    disp(string(tb_no) + ' tables detected'); 
    tb = list();


    for tb_cnt = 1:tb_no

        try
            xp_cur = xp(tb_cnt);

            if xp_cur.children(1).name =='tr';
                with_header = %f;
            else
                with_header = %t;
            end


            if with_header == %t then
                tb(tb_cnt) = %xmlScanTable_withheader(xp_cur);
            else
                tb(tb_cnt) = %xmlScanTable_noheader(xp_cur);
            end
        catch
            disp("Error processing table " + string(tb_cnt));
        end

    end




endfunction
