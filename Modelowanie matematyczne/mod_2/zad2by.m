% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego jawną metodą Eulera
size = 20;
a = linspace(10,200,size);
b = linspace(-40,0,size);
c = linspace(0,1,size);
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
                r_y = b(i2);
                r_yx = c(i3);
                r_yy = d(i4);
                f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
                yp(1) = a(i1);
                yp(2) = yp(1) + f(x(1),yp(1))*(t(2)-t(1));
                yp(3) = yp(2) + (1.5*f(x(2),yp(2)) - 0.5*f(x(1),yp(1)))*(t(3)-t(2));
                diff = (y(1)-yp(1))*(y(1)-yp(1)) + (y(2)-yp(2))*(y(2)-yp(2)) + (y(3)-yp(3))*(y(3)-yp(3));
                for n = 4:52
                    dt = t(n)-t(n-1);
                    yp(n) = yp(n-1) + (1/12)*(23*f(x(n-1),yp(n-1)) - 16*f(x(n-2),yp(n-2)) + 5*f(x(n-3),yp(n-3)))*dt;
                    diff = diff + (y(n)-yp(n))*(y(n)-yp(n));
                end
                if (diff < mdiff)
                    mr_y = r_y;
                    mr_yx = r_yx;
                    mr_yy = r_yy;
                    myp = yp(1);
                    mdiff = diff;
                end
            end
        end
    end
end

% Optymalizowanie
x0 = [myp, mr_y, mr_yx, mr_yy];
options = optimset('MaxFunEvals', 10000);
opt = fminsearch(@fun_2by, y0,options);

% Testowanie optymalnych
yp = zeros(1,52);
yp(1) = opt(1);
r_y = opt(2);
r_yx = opt(3);
r_yy = opt(4);
f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
yp(2) = yp(1) + f(x(1),yp(1))*(t(2)-t(1));
yp(3) = yp(2) + (1.5*f(x(2),yp(2)) - 0.5*f(x(1),yp(1)))*(t(3)-t(2));
for n = 4:52
    dt = t(n)-t(n-1);
    yp(n) = yp(n-1) + (1/12)*(23*f(x(n-1),yp(n-1)) - 16*f(x(n-2),yp(n-2)) + 5*f(x(n-3),yp(n-3)))*dt;
    diff = diff + (y(n)-yp(n))*(y(n)-yp(n));
end
plot(t,y,t,yp);
toc;