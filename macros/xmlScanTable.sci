function tb = xmlScanTable(doc,tbid,with_header)
    //  Import xml/html Table into Scilab
    //
    // Syntax
    //     tb = xmlScanTable(doc, tbname, with_header)
    //
    // Parameters
    //     doc : An xml document which is obtained from htmlRead
    //     tbid : Table id given in the "id" tag (second search on "class" tag)
    //     with_header : Table with header, default is %t
    //     tb : Return table in string
    //
    // Description
    //    This function used to extract xml/html table and return it to the Scilab as string.
    //    
    //    
    // See also
    //     xmlScanAllTable
    //
    // Authors
    //     C.L. Tan, Bytecode

    rhs=argn(2);
    lines(0);
    // Error Checking
    if rhs < 2; error("Expect at least 2 arguments, doc and tbid"); end    
    if rhs < 3; with_header = %t; end

    xp = xmlXPath(doc, '//table[contains(@id,""' + tbid + '"")]');
    if xp.size == 0 then
        xp = xmlXPath(doc, '//table[contains(@class,""' + tbid + '"")]');
    end
    
    // xp_cur = xp(1);
    tb_no = xp.size;
    disp(string(tb_no) + ' tables detected'); 
    tb = list();

    for tb_cnt = 1:tb_no

        try
            xp_cur = xp(tb_cnt);
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
