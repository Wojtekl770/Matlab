% Rozwiązanie równania y'' + 2y' + 2y = sin(x)
% Definicja funkcji a_coeff i b_coeff
fun = {@(x) 1, @(x) 2, @(x) 2 , @(x) sin(x)};

% Warunki początkowe
ic = [1; 0];
% Przedział czasowy
a = 0;
b = 20;
% Liczba kroków
n = 200;
% Wywołanie funkcji Rungego-Kutty 4-go rzędu
[yp, yk, xk] = P2Z47_WLA_Runge(fun, a, b, n, ic);



y0 = [1; 0];
% Przedział czasowy
x_span = [0, 10];
% Funkcja opisująca układ równań różniczkowych
ode_system = @(x, y) [y(2); sin(x) - 2*y(2) - 2*y(1)];
% Rozwiązanie równania za pomocą ode45
[x, y] = ode45(ode_system, x_span, y0);


% Wykres rozwiązania
plot(xk, yp,x, y(:, 1));
%plot(yk(2,:), yk(3,:));
legend('y(runge)', "y(ode)");
xlabel('x');
ylabel('y');
title('Rozwiązanie równania y'''' + 2y'' + 2y = sin(x)');
