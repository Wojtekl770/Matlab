function res = fun_2by(par)
    yp = zeros(1,52);
    yp(1) = par(1);
    r_y = par(2);
    r_yx = par(3);
    r_yy = par(4);
    dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
    dane = table2array(dane);
    t = dane(:,1)';
    x = dane(:,2)';
    y = dane(:,3)';
    f = @(x,y)  r_y*y + r_yx*x*y + r_yy*y*y;
    yp(2) = yp(1) + f(x(1),yp(1))*(t(2)-t(1));
    yp(3) = yp(2) + (1.5*f(x(2),yp(2)) - 0.5*f(x(1),yp(1)))*(t(3)-t(2));
    res = (y(1)-yp(1))*(y(1)-yp(1)) + (y(2)-yp(2))*(y(2)-yp(2)) + (y(3)-yp(3))*(y(3)-yp(3));
    for n = 4:52
        dt = t(n)-t(n-1);
        yp(n) = yp(n-1) + (1/12)*(23*f(x(n-1),yp(n-1)) - 16*f(x(n-2),yp(n-2)) + 5*f(x(n-3),yp(n-3)))*dt;
        res = res + (y(n)-yp(n))*(y(n)-yp(n));
    end

end