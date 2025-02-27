% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego metodą Adamsa-Bashfortha trzeciego rzędu
size = 20;
a = linspace(100,1000,size);
b = linspace(0,40,size);
c = linspace(-1,0,size);
d = linspace(-0.1,0,size);
xp = zeros(1,52);
mdiff = Inf;
tic;
for i1 = 1:size
    for i2 = 1:size
        for i3 = 1:size
            for i4 = 1:size
                xp(1) = a(i1);
                r_x = b(i2);
                r_xy = c(i3);
                r_xx = d(i4);
                f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
                xp(2) = xp(1) + f(xp(1),y(1))*(t(2)-t(1));
                xp(3) = xp(2) + (1.5*f(xp(2),y(2)) - 0.5*f(xp(1),y(1)))*(t(3)-t(2));
                diff = (x(1)-xp(1))*(x(1)-xp(1)) + (x(2)-xp(2))*(x(2)-xp(2)) + (x(3)-xp(3))*(x(3)-xp(3));
                for n = 4:52
                    dt = t(n)-t(n-1);
                    xp(n) = xp(n-1) + (1/12)*(23*f(xp(n-1),y(n-1)) - 16*f(xp(n-2),y(n-2)) + 5*f(xp(n-3),y(n-3)))*dt;
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
options = optimset('MaxFunEvals', 10000);
opt = fminsearch(@fun_2bx, x0,options);

% Testowanie optymalnych
xp = zeros(1,52);
xp(1) = opt(1);
r_x = opt(2);
r_xy = opt(3);
r_xx = opt(4);
f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
xp(2) = xp(1) + f(xp(1),y(1))*(t(2)-t(1));
xp(3) = xp(2) + (1.5*f(xp(2),y(2)) - 0.5*f(xp(1),y(1)))*(t(3)-t(2));
for n = 4:52
    dt = t(n)-t(n-1);
    xp(n) = xp(n-1) + (1/12)*(23*f(xp(n-1),y(n-1)) - 16*f(xp(n-2),y(n-2)) + 5*f(xp(n-3),y(n-3)))*dt;
    diff = diff + (x(n)-xp(n))*(x(n)-xp(n));
end
plot(t,x,t,xp);
toc;