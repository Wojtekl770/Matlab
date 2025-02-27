function res = fun_5(par)
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
    dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\IsleRoyale.csv");
    dane = table2array(dane);
    t = dane(:,1)';
    t = (t - min(t)) * 3 / (max(t) - min(t));
    x = dane(:,3)';
    y = dane(:,2)';
    fx = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
    fy = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
    res = 0;
   
    for n = 2:61
        dt = t(n)-t(n-1);
        xp(n) = xp(n-1) + fx(xp(n-1),y(n-1))*dt;
        yp(n) = yp(n-1) + fy(x(n-1),yp(n-1))*dt;
    end

    for n = 1:61
        res = res + (x(n)-xp(n))^2 + ((y(n)-yp(n))^2)*1000;
    end
end

