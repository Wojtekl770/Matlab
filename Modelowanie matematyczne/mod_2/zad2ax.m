% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego niejawną metodą Eulera
size = 8;
a = linspace(100,1000,size);
b = linspace(0,40,size);
c = linspace(-1,0,size);
d = linspace(-0.1,0,size);
xp = zeros(1,52);
yp = zeros(1,52);
mdiff = Inf;
diff = 0;
options = optimoptions('fsolve','Display','none','MaxFunEvals',30000);
tic;
for i1 = 1:size
    for i2 = 1:size
        for i3 = 1:size
            for i4 = 1:size
                xp(1) = a(i1);
                r_x = b(i2);
                r_xy = c(i3);
                r_xx = d(i4);
                diff = (x(1)-xp(1))*(x(1)-xp(1));
                f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
                for n = 2:52
                    dt = t(n)-t(n-1);
                    fx = @(xp_n) xp_n - (xp(n-1) + f(xp_n, y(n)) * (t(n) - t(n-1)));
                    %fx = @(x) x*x*r_xx*dt + x*(-1 + r_x*dt + r_xy*y(n)*dt) + xp(n-1);
                    xp(n) = fsolve(fx,xp(n-1),options);
                    diff = diff + (x(n)-xp(n))*(x(n)-xp(n));
                end
                if (diff < mdiff)
                    mr_x = r_x;
                    mr_xy = r_xy;
                    mr_xx = r_xx;
                    mxp = xp(1);
                    mdiff = diff;
                end
            end
        end
    end
end
toc;
tic;
% Optymalizacja
x0 = [mxp, mr_x, mr_xy, mr_xx];
options2 = optimset('MaxFunEvals', 30000);
opt = fminsearch(@fun_2ax, x0,options2);

% Testowanie optymalnych
xp = zeros(1,52);
xp(1) = opt(1);
r_x = opt(2);
r_xy = opt(3);
r_xx = opt(4);
f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
for n = 2:52
    dt = t(n)-t(n-1);
    fx = @(xp_n) xp_n - (xp(n-1) + f(xp_n, y(n)) * (t(n) - t(n-1)));
    %fx = @(x) x*x*r_xx*dt + x*(-1 + r_x*dt + r_xy*y(n)*dt) + xp(n-1);
    xp(n) = fsolve(fx,xp(n-1),options);
end

figure(1);
hold on;
plot(t,x,t,xp);
xlabel("Time");
ylabel("Prey Population");
legend('$\tilde{\mathbf{x}}_n$', '$\hat{\mathbf{x}}_n$', 'Interpreter', 'latex', 'FontSize', 14, 'FontAngle', 'italic');
print('p2ax.svg', '-dsvg');
hold off;
toc;