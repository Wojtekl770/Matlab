% Rozwiązanie równania y'' + 2y' + 2y = sin(x)
% Warunki początkowe
y0 = [1; 0];

% Przedział czasowy
x_span = [0, 30];

% Funkcja opisująca układ równań różniczkowych
ode_system = @(x, y) [y(2); sin(x) - 2*y(2) - 2*y(1)];

% Rozwiązanie równania za pomocą ode45
[x, y] = ode45(ode_system, x_span, y0);

% Wykres wyniku
figure;
plot(x, y(:, 1), 'LineWidth', 2);
title('Rozwiązanie równania y'''' + 2y'' + 2y = sin(x)');
xlabel('x');
ylabel('y');
grid on;
