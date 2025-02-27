function test2()
% y = e^-x + cos(x)
% y' = -e^-x - sin(x);
% y'' = e^-x -cos(x);
% y'' + 2y' + y = -2*sin(x)

% Warunki początkowe
ic = [2;-1];
% Przedział czasowy
a = 0;
b = 40;

% Liczba kroków
n = 200;

fun = {@(x) 1, @(x) 2, @(x) 1 , @(x) -2*sin(x)};


% Wywołanie funkcji Rungego-Kutty 4-go rzędu
[y0, yk, xk] = P2Z47_WLA_Runge(fun, a, b, n, ic);
y = @(x) exp(-x) + cos(x);
y_der = @(x) -exp(-x) - sin(x);



disp('Test 2:');
disp('-----------------------------------------------------------------');
disp('Obliczamy y metodą Rungego-Kutty 4-go rzędu dla równania postaci');
disp('y'''' + 2y'' + y = -2*sin(x)');

plot(y0, yk(3,:),y(xk),y_der(xk));
legend('przybliżona wartość', "dokładna wartość");
xlabel('y''');
ylabel('y');
title('Stosunek pochodnej rozwiązania do rozwiązania');
end
