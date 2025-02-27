% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego jawną metodą Eulera
size = 30;
a = linspace(100,1000,size);
b = linspace(0,40,size);
c = linspace(-1,0,size);
d = linspace(-0.1,0,size);
xp = zeros(1,52);
yp = zeros(1,52);
mdiff = Inf;
diff = 0;
tic;
for i1 = 1:size
    for i2 = 1:size
        for i3 = 1:size
            for i4 = 1:size
                xp(1) = a(i1);
                diff = (x(1)-xp(1))*(x(1)-xp(1));
                r_x = b(i2);
                r_xy = c(i3);
                r_xx = d(i4);
                f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
                for n = 2:52
                    dt = t(n)-t(n-1);
                    xp(n) = xp(n-1) + f(xp(n-1),y(n-1))*dt;
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

% Optymalizacja
x0 = [mxp, mr_x, mr_xy, mr_xx];
opt = fminsearch(@fun_1x, x0);

% Testowanie optymalnych
xp = zeros(1,52);
xp(1) = opt(1);
r_x = opt(2);
r_xy = opt(3);
r_xx = opt(4);
f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
for n = 2:52
    dt = t(n)-t(n-1);
    xp(n) = xp(n-1) + f(xp(n-1),y(n-1))*dt;
end

figure(1);
hold on;
plot(t,x,t,xp);
xlabel("Time");
ylabel("Prey Population");
legend('$\tilde{\mathbf{x}}_n$', '$\hat{\mathbf{x}}_n$', 'Interpreter', 'latex', 'FontSize', 14, 'FontAngle', 'italic');
%print('p1x.svg', '-dsvg');
hold off;
toc;