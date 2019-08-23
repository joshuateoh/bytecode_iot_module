function corr_matrix(data,str)
//  Creates a  correlation matrix graph
//
// Syntax
//    corr_matrix(data,str)
//
// Parameters
//     data : A N by N matrix containing values between -1 and 1 
//     str : A string vector with length N 
//
// Description
//    Creates a correlation matrix.
//
// Examples
//    data = rand(10,10)*2-1;
//    features = ["A" "B" "C" "D" "E" "F" "G" "H" "I" "J"];
//    corr_matrix(data,features)
//
// See also
//
// Authors
//     C.L. Tan, Bytecode   
//

    [y,x] = size(data);
    aa = data;
    aa = (aa+1).*32 + 1;
    aa(eye(aa) == 1) = 1;

    for row = 1:y
        for col = row:x
            aa(row,col) = 1;
        end
    end
    Matplot(aa,'082');
    f = gcf();
    f.color_map = [[1 1 1];jetcolormap(64)];


    for row = 1:y
        for col = row:x
            if col == row
                xstring(row-0.5,x-col+1-0.5,str(col));
            else
                xstring(row-0.5,x-col+1-0.5,string(round(data(row,col)*100)/100));
            end

        end
    end

endfunction
