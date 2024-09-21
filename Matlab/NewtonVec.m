function [x, xVec, ErrVec, IterNum] =  NewtonVec(x0, TOL, f, fdiff)

x = x0;
Error = abs(f(x0)); % residual of the initial value
IterNum = 0;

fprintf(['\n Iter: %d, x = %0.5f, residual |f(x)| = %0.5f'],...
        IterNum, x, Error);

xVec = x0;
ErrVec = Error;

while Error > TOL
       
    x = x - f(x)/fdiff(x); % Newton's update formula
    Error  = abs(f(x));
    IterNum = IterNum  + 1;
    
    fprintf(['\n Iter: %d, x = %0.5f, residual |f(x)| = %0.5f'],...
        IterNum, x, Error);
    
    % update xVec, ErrVec
    xVec = [xVec, x];
    ErrVec = [ErrVec, Error];
    

end
fprintf(['\n '])