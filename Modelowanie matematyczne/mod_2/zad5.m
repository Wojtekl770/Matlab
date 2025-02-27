% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\IsleRoyale.csv");
dane = table2array(dane);
t = dane(:,1)';
y = dane(:,2)';
x = dane(:,3)';
% Przeskalowanie wektora czasu
t = (t - min(t)) * 3 / (max(t) - min(t));

% Szukanie zestawu początkowego x jawną metodą Eulera
size = 30;
a = linspace(100,600,size);
b = linspace(0,40,size);
c = linspace(-1,0,size);
d = linspace(-0.2,0.1,size);
xp = zeros(1,61);
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
                fx = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
                for n = 2:61
                    dt = t(n)-t(n-1);
                    xp(n) = xp(n-1) + fx(xp(n-1),y(n-1))*dt;
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
options2 = optimset('MaxFunEvals', 60000, 'MaxIter', 60000);
y0 = [20 0 0 0];
y1 = fminsearch(@fun_5b,y0,options2);
ic  = [mxp, mr_x, mr_xy, mr_xx, y1(1), y1(2), y1(3), y1(4)];
par = fminsearch(@fun_5, ic, options2);

% Testowanie optymalnych
xp = zeros(1,61);
yp = zeros(1,61);
xp(1) = par(1);
r_x = par(2);
r_xy = par(3);
r_xx = par(4);
yp(1) = par(5);
r_y = par(6);
r_yx = par(7);
r_yy = par(8);
fx = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
fy = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;

for n = 2:61
    dt = t(n)-t(n-1);
    xp(n) = xp(n-1) + fx(xp(n-1),y(n-1))*dt;
    yp(n) = yp(n-1) + fy(x(n-1),yp(n-1))*dt;
end

subplot(2,1,1);
plot(t,xp,t,x);
subplot(2,1,2);
plot(t,yp,t,y);
toc;
