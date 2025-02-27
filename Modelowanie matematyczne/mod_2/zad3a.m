% Importowanie danych z pliku
clearvars;
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego x jawną metodą Eulera
size = 15;
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
                diff = 0;
                xp(1) = a(i1);
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

% Szukanie zestawu początkowego y jawną metodą Eulera
a = linspace(10,200,size);
b = linspace(-40,0,size);
c = linspace(0,1,size);
d = linspace(-0.1,0,size);
yp = zeros(1,52);
mdiff = Inf;
diff = 0;
tic;
for i1 = 1:size
    for i2 = 1:size
        for i3 = 1:size
            for i4 = 1:size
                diff = 0;
                yp(1) = a(i1);
                r_y = b(i2);
                r_yx = c(i3);
                r_yy = d(i4);
                f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
                for n = 2:52
                    dt = t(n)-t(n-1);
                    yp(n) = yp(n-1) + f(x(n-1),yp(n-1))*dt;
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

% Optymalizacja za pomocą ode45
ic = [mxp, mr_x, mr_xy, mr_xx, myp, mr_y, mr_yx, mr_yy];
options2 = optimset('MaxFunEvals', 30000);
par = fminsearch(@fun_3a,ic,options2);

% Testowanie optymalnych
xp(1) = par(1);
r_x = par(2);
r_xy = par(3);
r_xx = par(4);
yp(1) = par(5);
r_y = par(6);
r_yx = par(7);
r_yy = par(8);
fx = @(t, z) r_x * z(1) + r_xy * z(1) * z(2) + r_xx * z(1) * z(1);
fy = @(t, z) r_y * z(2) + r_yx * z(1) * z(2) + r_yy * z(2) * z(2);
tspan = [0,3];
eq = @(t, z) [fx(t, z); fy(t, z)];
ic = [xp(1), yp(1)];
[tz, z] = ode45(eq, tspan, ic);
z = z';
tz = tz';
xp = interp1(tz, z(1,:), t, 'linear');
yp = interp1(tz, z(2,:), t, 'linear');

subplot(2,1,1);
plot(t,xp,t,x);
subplot(2,1,2);
plot(t,yp,t,y);
toc;
