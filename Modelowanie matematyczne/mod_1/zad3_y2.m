syms t y1(t) y2(t);
tspan = [0,8];
x = @(t) exp(-t)*sin(t);
Y1 = diff(y1,t);
Y2 = diff(y2,t);
eq = [
    y2(t) == (Y1 + 19/3*y1(t) - x(t))*1.5;
    y1(t) == (-Y2 - 14/3*y2(t) + x(t))*1.5;
    ];
ic = [
    y1(0) == 0;
    y2(0) == 0;
    ];
[y1,y2] = dsolve(eq,ic);

% Dane
A = [-19/3, 2/3; -2/3, -14/3];
b = [1;1];
f = @(t,y) A*y + b*x(t);
f1 = matlabFunction(y1);
f2 = matlabFunction(y2);
h = logspace(-2,-0.5,200);
I = [1,0;0,1];

% Podpunkt b
errb = zeros(2,length(h));
for i = 1:length(h)
    dt = h(i);
    tspan = [0,8];
    t = tspan(1) : dt : tspan(2);
    N = length(t);
    yb = zeros(2,N);
    yb(:,2) =yb(:,1)+ dt*f(t(1),yb(:,1));
    
    for j = 3:N
        yb(:,j) = yb(:,j-1) + dt/2*(3*f(t(j-1),yb(:,j-1)) - f(t(j-2),yb(:,j-2)));
    end

    k = zad3(f1,f2,yb,dt);
    errb(1,i) = k(1);
    errb(2,i) = k(2);
end

% Podpunkt c
errc = zeros(2,length(h));
for i = 1:length(h)
    dt = h(i);
    tspan = [0,8];
    t = tspan(1) : dt : tspan(2);
    N = length(t);
    yc = zeros(2,N);
    yc(:,2) = (I - A*dt) \ ( dt*f(t(2),yc(:,2)) );
    
    for j = 3:N
        yc(:,j) = (I - A*dt) \ ( yc(:,j-2) + dt*f(t(j-2),yc(:,j-2)) + dt*b*x(t(j-2)));
    end


    k = zad3(f1,f2,yc,dt);
    errc(1,i) = k(1);
    errc(2,i) = k(2);
end

% Podpunkt d
errd = zeros(2,length(h));
for j = 1:length(h)
    dt = h(j);
    tspan = [0,8];
    t = tspan(1) : dt : tspan(2);
    N = length(t);
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


    k = zad3(f1,f2,yd,dt);
    errd(1,j) = k(1);
    errd(2,j) = k(2);
end

loglog(h,errb(2,:),h,errc(2,:),h,errd(2,:));
title('Error for y2');
xlabel("size of h");
ylabel("Error");
legend(["y1b","y1c","y1d"],'Location','northwest');
saveas(gcf, 'wykres3_y2.svg', 'svg');