function res = fun_3b(par)
    xp = zeros(1,52);
    yp = zeros(1,52);
    xp(1) = par(1);
    r_x = par(2);
    r_xy = par(3);
    r_xx = par(4);
    yp(1) = par(5);
    r_y = par(6);
    r_yx = par(7);
    r_yy = par(8);
    dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
    dane = table2array(dane);
    t = dane(:,1)';
    x = dane(:,2)';
    y = dane(:,3)';
    fx = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
    fy = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
    res = 0;
   
    for n = 2:52
        dt = t(n)-t(n-1);
        xp(n) = xp(n-1) + fx(xp(n-1),yp(n-1))*dt;
        yp(n) = yp(n-1) + fy(xp(n-1),yp(n-1))*dt;
    end

    for n = 1:52
        res = res + (x(n)-xp(n))*(x(n)-xp(n)) + (y(n)-yp(n))*(y(n)-yp(n));
    end
end

