function y = smooth2(x, n)
//  Smooth A Signal With Moving Average Method
//
// Syntax
//     y = smooth2(x, n)
//
// Parameters
//     x : Input signal
//     n : Number of points used for averaging
//     y : Filtered signal
//
// Description
//      Smooth a signal by using moving average method with given number of points
// 
// See also
//
// Authors
//     Tan C.L., Bytecode  
  
  sz = size(x);
  if sz(1) < sz(2) then 
    x = x';
    dim = sz(2);
  else 
    dim = sz(1);
  end,
  
  
//  y = zeros(dim - n, 1);
  y = zeros(dim, 1);
//  
//  for cnt = 1:dim ,
//      if  cnt-n+1 <= 0 then
//          y(cnt) = mean(x(1:cnt));
//      else
//          y(cnt) = mean(x(cnt-n+1:cnt));
//      end
//  end,

//  for cnt = 1:dim ,
//      if  cnt > dim-n+1 then
//          y(cnt) = mean(x(cnt:$));
//      else
//          y(cnt) = mean(x(cnt:cnt+n-1));
//      end
//  end,

  for cnt = 1:dim ,
      if  cnt <= floor(n/2) then
          y(cnt) = mean(x(1:cnt));
      elseif cnt >= ceil(dim - n/2)
          y(cnt) = mean(x(cnt:$));
      else
          y(cnt) = mean(x(cnt-floor(n/2):cnt+ceil(n/2)));
      end
  end,
 
endfunction
