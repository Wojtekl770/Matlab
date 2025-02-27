clearvars;
f = @(x) x.^2;
n = [3,5,7,9,15];
a = 0;
b = 10000;


res = P1Z44_WLA_Gauss_Legendre(f,a,b,n);
por = integral(f,a,b);
disp(res);
disp(por);
r = res - por;
disp(r);

% zrób funkcje porownujaca do integrala i dopisz by wyswietlala sie funkcja
