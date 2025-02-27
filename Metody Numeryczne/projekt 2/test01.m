% Definicja równania różniczkowego y' + y = 0
fun = {@(x) 1, @(x) 1, @(x) 0};

% Warunki początkowe
ic = 1;  % Przykładowe warunki początkowe y(0) = 1
% Przedział czasowy
a = 0;
b = 20;

% Liczba kroków
n = 100;

% Wywołanie funkcji Rungego-Kutty 4-go rzędu
[y0,yk, xk] = P2Z47_WLA_Runge(fun, a, b, n, ic);

% Wykres wyników
figure;
plot(xk, yk(2, :), 'LineWidth', 2);
title('Rozwiązanie równania y'' + y = 0');
xlabel('x');
ylabel('y');
grid on;

