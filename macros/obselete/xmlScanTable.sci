function tb = xmlScanTable(doc, tbname,level)
//  Import xml/html Table into Scilab
//
// Syntax
//     tb = xmlScanTable(doc, tbname,level)
//
// Parameters
//     doc : An xml document which is obtained from htmlRead
//     tbname : Table name given in the "class" tag
//     level : The nth level to the access of table data
//     tb : Return table in string
//
// Description
//    This function used to extract xml/html table and return it to the Scilab as string.
//    
//    
// See also
//
// Authors
//     C.L. Tan, Bytecode

    rhs=argn(2);
    lines(0);
    // Error Checking
    if rhs < 2; error("Expect at least 2 arguments, doc and tbname"); end    
    if rhs < 3; level = 1; end


    if level == 1 then
        xp = xmlXPath(doc, '//table[contains(@class,""' + tbname + '"")]');
        rows = xp(1).children.size;
        cols = xp(1).children(1).children.size;

        tb = '';
        for cnt1 = 1:rows,
            for cnt2 = 1:cols,
                tmpdata = xp(1).children(cnt1).children(cnt2).content;
                tmpdata2 = stripblanks(strcat(tmpdata));
                if ascii(tmpdata2) == 13 then 
                    tmpdata2 = '';
                end,
                tb(cnt1, cnt2) = tmpdata2;

            end,
        end,
    else
        xp = xmlXPath(doc, '//table[contains(@class,""' + tbname + '"")]');
    
        xp = xp(1).children(level);
        //  pause
        rows = xp.children.size;
        cols = max([xp.children(rows/1).children.size,...
                    xp.children(rows/2).children.size,...
                    xp.children(rows/3).children.size,...
                    xp.children(rows/4).children.size]);

        tb = '';
        for cnt1 = 1:rows,
            for cnt2 = 1:cols,
                try
                    tmpdata = xp.children(cnt1).children(cnt2).content;
                    tmpdata2 = stripblanks(strcat(tmpdata));
                catch
                    tmpdata2 = '';
                end
                if ascii(tmpdata2) == 13 then 
                    tmpdata2 = '';
                end,
                tb(cnt1, cnt2) = tmpdata2;

            end,
        end,

    end


endfunction
