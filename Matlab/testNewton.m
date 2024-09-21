% Test Newton's method

% Define function 
f1 = @(x) x.^4 -2*x.^3 -10;

% Define derivative of function
f1diff = @(x) 4*(x.^3) -6*(x.^2);

% plot the function f

xvalues = linspace(-5, 5, 100);
figure,
plot(xvalues, f1(xvalues), 'b-.')
title('Plot of function f(x)')
grid on;

%% Call NewtonVec
x0 = 1;
TOL = 1e-4;

[x, xVec, ErrVec, IterNum] =  NewtonVec(x0, TOL, f1, f1diff); 

IterVec = 0:IterNum;

%plots
figure,
plot(IterVec, xVec, 'r*--')
title('Approximate Values from Newton Method')
xlabel('Iteration Number')
ylabel('Approximate values')
grid on;

figure,
%plot(IterVec, ErrVec, 'bo--')
semilogy(IterVec, ErrVec, 'bo--')
title('Residual from Newton Method')
xlabel('Iteration Number')
ylabel('Residual')
grid on;
