function res = fun_5b(par)
    yp = zeros(1,52);
    yp(1) = par(1);
    r_y = par(2);
    r_yx = par(3);
    r_yy = par(4);
    dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\IsleRoyale.csv");
    dane = table2array(dane);
    t = dane(:,1)';
    t = (t - min(t)) * 3 / (max(t) - min(t));
    x = dane(:,3)';
    y = dane(:,2)';
    f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
    res = (y(1)-yp(1))*(y(1)-yp(1));


    for n = 2:52
        dt = t(n)-t(n-1);
        yp(n) = yp(n-1) + f(x(n-1),yp(n-1))*dt;
        res = res + (y(n)-yp(n))*(y(n)-yp(n));
    end
end