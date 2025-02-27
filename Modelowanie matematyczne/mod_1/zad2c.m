% Dane
clearvars;
tspan = [0,8];
x = @(t) exp(-t)*sin(t);
A = [-19/3, 2/3; -2/3, -14/3];
b = [1;1];
dt = 0.01;
t = tspan(1) : dt : tspan(2);
N = length(t);
I = [1,0;0,1];
f = @(t,y) A*y + b*x(t);

% Podpunkt c
y = zeros(2,N);
y(:,2) = (I - A*dt) \ ( dt*f(t(2),y(:,2)));

for i = 3:N
    y(:,i) = (I - A*dt) \ ( y(:,i-2) + dt*f(t(i-2),y(:,i-2)) + dt*b*x(t(i-2)));
end

figure(1);
hold on;
plot(t, y(1,:));
plot(t, y(2,:));
xlabel("t");
ylabel("y");
legend("y1","y2");
hold off;