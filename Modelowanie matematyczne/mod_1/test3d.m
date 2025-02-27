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
h = logspace(-3,0.53,200);
I = [1,0;0,1];

errb = zeros(2,length(h));
for j = 1:length(h)

    % Podpunkt d
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
    errb(1,j) = k(1);
    errb(2,j) = k(2);
end
loglog(h,errb);
xlabel("size of h");
ylabel("Error");
legend(["y1","y2"],'Location','northwest');