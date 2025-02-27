% Dane
clearvars;
tspan = [0,8];
x = @(t) exp(-t)*sin(t);
A = [-19/3, 2/3; -2/3, -14/3];
b = [1;1];
dt = 0.01;
t = tspan(1) : dt : tspan(2);
N = length(t);
f = @(t,y) A*y + b*x(t);

% Podpunkt b
y = zeros(2,N);
y(:,2) =y(:,1)+ dt*f(t(1),y(:,1));

for i = 3:N
    y(:,i) = y(:,i-1) + dt/2*(3*f(t(i-1),y(:,i-1)) - f(t(i-2),y(:,i-2)));

end

figure(1);
hold on;
plot(t, y(1,:));
plot(t, y(2,:));
xlabel("t");
ylabel("y");
legend("y1","y2");
hold off;