% Bisection 

f1 = @(x) x.^4 -2*x.^3 -10;



% plot the function f

xvalues = linspace(-5, 5, 100);
figure,
plot(xvalues, f1(xvalues), 'b-.')
title('Plot of function f(x)')
grid on;

a = 1;
b = 3;
TOL = 1e-4;
[x, xVec, ErrVec] = BisectionVec(a,b, TOL , f1); 

% Plot the approximations and residuals
Total_Iter = length(xVec);
IterVec = 1:1:Total_Iter;
figure,
plot(IterVec, xVec, 'r*--')
title('Approximate Values from Bisection')
xlabel('Iteration Number')
ylabel('Approximate values')
grid on;

figure,
%plot(IterVec, ErrVec, 'bo--')
semilogy(IterVec, ErrVec, 'bo--')
title('Residual from Bisection')
xlabel('Iteration Number')
ylabel('Residual')
grid on;




