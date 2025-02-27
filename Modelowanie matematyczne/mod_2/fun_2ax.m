function res = fun_2ax(par)
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
    res = (x(1)-xp(1))*(x(1)-xp(1));
    options = optimoptions('fsolve','Display','none','MaxFunEvals',30000);

    for n = 2:52
        dt = t(n)-t(n-1);
        fx = @(x) x*x*r_xx*dt + x*(-1 + r_x*dt + r_xy*y(n)*dt) + xp(n-1);
        xp(n) = fsolve(fx,xp(n-1),options);
        res = res + (x(n)-xp(n))*(x(n)-xp(n));
    end
end