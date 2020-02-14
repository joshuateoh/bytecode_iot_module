function str=iot_display(h)
    pt = h.data;
    hh = gca();
    x = hh.user_data;
    str=msprintf('%s\n %g', x(pt(1)),pt(2))
endfunction
