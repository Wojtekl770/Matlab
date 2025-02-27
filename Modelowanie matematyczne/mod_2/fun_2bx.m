function res = fun_2bx(par)
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
    xp(2) = xp(1) + f(xp(1),y(1))*(t(2)-t(1));
    xp(3) = xp(2) + (1.5*f(xp(2),y(2)) - 0.5*f(xp(1),y(1)))*(t(3)-t(2));
    res = (x(1)-xp(1))*(x(1)-xp(1)) + (x(2)-xp(2))*(x(2)-xp(2))+ (x(3)-xp(3))*(x(3)-xp(3));
    
    for n = 4:52
        dt = t(n)-t(n-1);
        xp(n) = xp(n-1) + (1/12)*(23*f(xp(n-1),y(n-1)) - 16*f(xp(n-2),y(n-2)) + 5*f(xp(n-3),y(n-3)))*dt;
        res = res + (x(n)-xp(n))*(x(n)-xp(n));
    end
end