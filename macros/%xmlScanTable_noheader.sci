function tb = %xmlScanTable_noheader(xp)
    //  Internal function to mport xml/html table without header
    //
    // Syntax
    //     tb = %xmlScanTable_noheader(xp)
    //
    // Parameters
    //     xp : An xml element which is obtained from doc with XPath query 
    //     tb : Return table in string
    //
    // Description
    //    This function is used internally to extract xml/html table and return it to the Scilab as string.
    //    
    //    
    // See also
    //     %xmlScanTable_withheader
    //
    // Authors 
    //     C.L. Tan, Bytecode

    rhs=argn(2);
    lines(0);
    // Error Checking
    if rhs < 1; error("Expect 1 argument, xml"); end    
    xp_cur = xp;
    
    // No header
    tb_temp = [];
    tb = [];

    rows = xp_cur.children.size;
    cols = xp_cur.children(1).children.size;
    for cnt1 = 1:rows,
        for cnt2 = 1:cols,
            tmpdata = xp_cur.children(cnt1).children(cnt2).content;
            tmpdata2 = stripblanks(strcat(tmpdata));
            if ascii(tmpdata2) == 13 then 
                tmpdata2 = '';
            end
            tb_temp(cnt1, cnt2) = tmpdata2;
        end
    end
    tb = tb_temp;



endfunction
