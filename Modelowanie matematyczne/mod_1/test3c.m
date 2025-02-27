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
h = logspace(-2,0.53,200);
I = [1,0;0,1];

errb = zeros(2,length(h));
for i = 1:length(h)

    % Podpunkt c
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
    errb(1,i) = k(1);
    errb(2,i) = k(2);
end
loglog(h,errb);
xlabel("size of h");
ylabel("Error");
legend(["y1","y2"],'Location','northwest');