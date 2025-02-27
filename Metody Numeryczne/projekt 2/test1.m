function test1()
% y = e^-x + cos(x)
% y' = -e^-x - sin(x);
% y'' = e^-x -cos(x);
% y'' + 2y' + y = -2*sin(x)

% Warunki początkowe
ic = [2;-1];
% Przedział czasowy
a = 0;
b = 20;

% Liczba kroków
n = 100;

fun = {@(x) 1, @(x) 2, @(x) 1 , @(x) -2*sin(x)};


% Wywołanie funkcji Rungego-Kutty 4-go rzędu
[y0, yk, xk] = P2Z47_WLA_Runge(fun, a, b, n, ic);
y = @(x) exp(-x) + cos(x);



disp('Test 1:');
disp('-----------------------------------------------------------------');
disp('Obliczamy y metodą Rungego-Kutty 4-go rzędu dla równania postaci');
disp('y'''' + 2y'' + y = -2*sin(x)');

plot(xk, y0,xk, y(xk));
legend('przybliżona wartość', "dokładna wartość");
xlabel('x');
ylabel('y');
title('Rozwiązanie równania y'''' + 2y'' + y = -2*sin(x)');
end

