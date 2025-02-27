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

plot(t, yd(1,:), t, yd(2,:));
xlabel("t");
ylabel("y");
legend("y1","y2");
hold off;