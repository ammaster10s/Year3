function [x, xVec, ErrVec] = BisectionVec(a,b, TOL , f)

Error = TOL + 100; 
IterNumber = 0;
xVec = [];
ErrVec = [];
while Error > TOL
    
    x = (a + b)/2;
    Error = abs(f(x)); % Residual
    IterNumber = IterNumber  + 1;
    
    fprintf(['\n Iter: %d, [a,b] = [%0.5f, %0.5f], x = %0.5f, residual |f(x)| = %0.5f'],...
        IterNumber,a, b, x, Error);
    
    % Store approximation values and errors
    xVec = [xVec, x];
    ErrVec = [ErrVec, Error];
    
    % update [a,b]
    if f(a)*f(x) < 0
        b = x;
    else
        a = x;
    end
    
end

fprintf(['\n '])
