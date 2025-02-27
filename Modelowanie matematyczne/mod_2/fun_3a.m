function res = fun_3a(par)
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
    fx = @(t, z) r_x * z(1) + r_xy * z(1) * z(2) + r_xx * z(1) * z(1);
    fy = @(t, z) r_y * z(2) + r_yx * z(1) * z(2) + r_yy * z(2) * z(2);
    tspan = [0,3];
    eq = @(t, z) [fx(t, z); fy(t, z)];
    ic = [xp(1), yp(1)];
    [tz, z] = ode45(eq, tspan, ic);
    z = z';
    xp = interp1(tz, z(1,:), t, 'linear');
    yp = interp1(tz, z(2,:), t, 'linear');
    res = 0;
    
    for n = 1:52
        res = res + (x(n)-xp(n))*(x(n)-xp(n)) + (y(n)-yp(n))*(y(n)-yp(n));
    end
end

