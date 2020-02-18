function tb = %xmlScanTable_withheader(xp)
    //  Internal function to mport xml/html table with header
    //
    // Syntax
    //     tb = %xmlScanTable_withheader(xp)
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
    //     %xmlScanTable_noheader
    //
    // Authors 
    //     C.L. Tan, Bytecode

    rhs=argn(2);
    lines(0);
    // Error Checking
    if rhs < 1; error("Expect 1 argument, xml"); end    

    xp_cur = xp;
    
    // with header
    tb_temp = [];
    tb = [];
    cols = [0 0];
    
    // Loop throught header and body
    for cc = 1:2
        rows = xp_cur.children(cc).children.size;
        for col_cnt = 1:rows
            cols_max(col_cnt) = xp_cur.children(cc).children(col_cnt).children.size;
        end
        cols(cc) = max(cols_max);
        tb_temp = [];
        for cnt1 = 1:rows,
            for cnt2 = 1:cols(cc),
                tmpdata = xp_cur.children(cc).children(cnt1).children(cnt2).content;
                tmpdata2 = stripblanks(strcat(tmpdata));
                if ascii(tmpdata2) == 13 | tmpdata2 == [] then 
                    tmpdata2 = '';
                end
                tb_temp(cnt1, cnt2) = tmpdata2;
            end
        end
        
        // Combine the header and body if they are in the same columns size
        if cols(1) == cols(2)
            tb = [tb;tb_temp];
        else
            tb = tb_temp;
        end

    end




endfunction
