% Importowanie danych z pliku
dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
dane = table2array(dane);
t = dane(:,1)';
x = dane(:,2)';
y = dane(:,3)';

% Szukanie zestawu początkowego niejawną metodą Eulera
size = 5;
a = linspace(10,200,size);
b = linspace(-40,0,size);
c = linspace(0,1,size);
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
                yp(1) = a(i1);
                r_y = b(i2);
                r_yx = c(i3);
                r_yy = d(i4);
                diff = (y(1)-yp(1))*(y(1)-yp(1));
                for n = 2:52
                    dt = t(n)-t(n-1);
                    fy = @(y) y*y*r_yy*dt + y*(-1 + r_y*dt + r_yx*x(n)*dt) + yp(n-1);
                    yp(n) = fsolve(fy,yp(n-1),options);
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
toc;
tic;

% Optymalizowanie
y0 = [myp, mr_y, mr_yx, mr_yy];
options2 = optimset('MaxFunEvals', 30000);
opt = fminsearch(@fun_2ay, y0,options2);

% Testowanie optymalnych
yp = zeros(1,52);
yp(1) = opt(1);
r_y = opt(2);
r_yx = opt(3);
r_yy = opt(4);
f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
for n = 2:52
    dt = t(n)-t(n-1);
    fy = @(y) y*y*r_yy*dt + y*(-1 + r_y*dt + r_yx*x(n)*dt) + yp(n-1);
    yp(n) = fsolve(fy,yp(n-1),options);
end

figure(1);
hold on;
plot(t,y,t,yp);
xlabel("Time");
ylabel("Predator Population");
legend('$\tilde{\mathbf{y}}_n$', '$\hat{\mathbf{y}}_n$', 'Interpreter', 'latex', 'FontSize', 14, 'FontAngle', 'italic');
print('p2ay.svg', '-dsvg');
hold off;
toc;