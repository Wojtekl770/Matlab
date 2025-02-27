% Dane
clearvars;
tspan = [0,8];
x = @(t) exp(-t)*sin(t);
A = [-19/3, 2/3; -2/3, -14/3];
b = [1;1];
dt = 0.01;
I = [1,0;0,1];
f = @(t,y) A*y + b*x(t);

% Podpunkt a
ic = [0;0];
[ta,ya] = ode45(f,tspan,ic);

% Podpunkt b
t = tspan(1) : dt : tspan(2);
N = length(t);
yb = zeros(2,N);
yb(:,2) =yb(:,1)+ dt*f(t(1),yb(:,1));

for i = 3:N
    yb(:,i) = yb(:,i-1) + dt/2*(3*f(t(i-1),yb(:,i-1)) - f(t(i-2),yb(:,i-2)));
end

% Podpunkt c
yc = zeros(2,N);
yc(:,2) = (I - A*dt) \ ( dt*f(t(2),yc(:,2)));

for i = 3:N
    yc(:,i) = (I - A*dt) \ ( yc(:,i-2) + dt*f(t(i-2),yc(:,i-2)) + dt*b*x(t(i-2)));
end



% Podpunkt d
yd = zeros(2,N);
L = [ I - A.*(1/6).*dt , A.*(1/3).*dt , A.*(-1/6).*dt;
      A.*(-1/6).*dt , I - A.*(5/12).*dt, A.*(1/12).*dt;
      A.*(-1/6).*dt , A.*(-2/3).*dt, I - A.*(1/6).*dt    
    ];

w = [1/6, 2/3, 1/6];


for i = 2:N
    p = [ f(t(i-1),yd(:,i-1));
          f(t(i-1),yd(:,i-1)) + b*x(1/2*dt);
          f(t(i-1),yd(:,i-1)) + b*x(dt);
        ];
    F = L\p;
    yd(1,i) =  yd(1,i-1) + (F(1)*w(1) + F(3)*w(2) + F(5)*w(3)).*dt;
    yd(2,i) =  yd(2,i-1) + (F(2)*w(1) + F(4)*w(2) + F(6)*w(3)).*dt;
end

% Wykresy

figure(1);
hold on;
subplot(2,2,1);
plot(ta, ya(:,1), ta, ya(:,2));
title('Metoda A');

subplot(2,2,2);
plot(t, yb(1,:), t, yb(2,:));
title('Metoda B');

subplot(2,2,3);
plot(t, yc(1,:), t, yc(2,:));
title('Metoda C');

subplot(2,2,4);
plot(t, yd(1,:), t, yd(2,:));
title('Metoda D');

% plot(ta, ya(:,2),t,yb(2,:),t,yc(2,:),t,yd(2,:));
% xlabel("t");
% ylabel("y");
% legend("y2a","y2b","y2c","y2d");

hold off;