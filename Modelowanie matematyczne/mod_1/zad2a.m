% Dane
clearvars;
tspan = [0,8];
x = @(t) exp(-t)*sin(t);
A = [-19/3, 2/3; -2/3, -14/3];
b = [1;1];

% Podpunkt a
f = @(t,y) A*y + b*x(t);
ic = [0;0];
[t,y] = ode45(f,tspan,ic);

figure(1);
hold on;
plot(t, y(:,1));
plot(t, y(:,2));
xlabel("t");
ylabel("y");
legend("y1","y2");
hold off;