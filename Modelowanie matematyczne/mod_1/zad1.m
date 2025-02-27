clearvars;
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
figure(1);
clf
hold on;
fplot(y1,tspan);
fplot(y2,tspan);
xlabel("t");
ylabel("y");
legend("y1","y2");
hold off;