function res = fun_2ay(par)
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
    res = (y(1)-yp(1))*(y(1)-yp(1));
    options = optimoptions('fsolve','Display','none','MaxFunEvals',30000);

    for n = 2:52
        dt = t(n)-t(n-1);
        fy = @(y) y*y*r_yy*dt + y*(-1 + r_y*dt + r_yx*x(n)*dt) + yp(n-1);
        yp(n) = fsolve(fy,yp(n-1),options);
        res = res + (y(n)-yp(n))*(y(n)-yp(n));
    end
end