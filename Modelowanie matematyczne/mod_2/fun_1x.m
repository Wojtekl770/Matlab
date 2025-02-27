function res = fun_1x(par)
    xp = zeros(1,52);
    xp(1) = par(1);
    r_x = par(2);
    r_xy = par(3);
    r_xx = par(4);
    dane = readtable("C:\Users\Wojte\Desktop\MATLAB\semestr_3\mod_2\dane35.csv");
    dane = table2array(dane);
    t = dane(:,1)';
    x = dane(:,2)';
    y = dane(:,3)';
    f = @(x,y)  r_x*x + r_xy*x*y + r_xx*x*x;
    res = (x(1)-xp(1))*(x(1)-xp(1));

    for n = 2:52
        dt = t(n)-t(n-1);
        xp(n) = xp(n-1) + f(xp(n-1),y(n-1))*dt;
        res = res + (x(n)-xp(n))*(x(n)-xp(n));
    end
end