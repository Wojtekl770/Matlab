function test3()
% y = e^-x + cos(x)
% y' = -e^-x - sin(x);
% y'' = e^-x -cos(x);
% y(3) = -e^-x +sin(x)
% y^(3) + y'' + y' + y = -sin(x) - cos(x)

% Warunki początkowe
ic = [2;-1;0];
% Przedział czasowy
a = 0;
b = 30;

% Liczba kroków
n = 100;

fun = {@(x) 1 @(x) 2, @(x) 2 , @(x) 1, @(x) -sin(x) - cos(x)};


% Wywołanie funkcji Rungego-Kutty 4-go rzędu
[y0, yk, xk] = P2Z47_WLA_Runge(fun, a, b, n, ic);
y = @(x) exp(-x) + cos(x);



disp('Test 3:');
disp('-----------------------------------------------------------------');
disp('Obliczamy y metodą Rungego-Kutty 4-go rzędu dla równania postaci');
disp('y'''''' + y'''' + 3y'' + y = -3*sin(x) - cos(x)');

plot(xk, yk(2,:),xk, y(xk));
legend('przybliżona wartość', "dokładna wartość");
xlabel('y''');
ylabel('y');
title('Rozwiązanie równania y'''''' + y'''' + 3y'' + y = -3*sin(x) - cos(x)');
end