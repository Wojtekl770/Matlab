function res = fun_4(x)
    par = [456.1064    9.8130   -0.0686   -0.0213   79.8565   -5.4496    0.0514   -0.0337];
    r_x = par(2);
    r_xy = par(3);
    r_xx = par(4);
    r_y = par(6);
    r_yx = par(7);
    r_yy = par(8);
    res = (r_x*x(1) + r_xy*x(1)*x(2) + r_xx*x(1)*x(1))^2 + (r_y*x(2) + r_yx*x(1)*x(2) + r_yy*x(2)*x(2))^2;
end

