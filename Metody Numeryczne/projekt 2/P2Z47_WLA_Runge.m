function [y0,Y,xk] = P2Z47_WLA_Runge(fun,a,b,n,ic)
% Projekt 2, zadanie 47
% Wojciech Łapan, 327374
%
% Obliczanie liniowych równań różniczkowych metodą
% Rungego-Kutty 4-go rzędu postaci 
% am(x)*y^(m) + ... + a1(x)*y' + a0(x)*y = b(x)
%
% Wejście:
% - fun  - Wektor uchwytów do funkcji rzeczywistych, opisujących
%          układ równań różniczkowych i nie znikających
%          na przedziale całkowania {am, ...,a1, a0, b}
% - a    - Początek przedziału całkowania
% - b    - Koniec przedziału całkowania (b > a)
% - n    - Liczba kroków do wykonania
% - ic   - Wektor pionowy warunków początkowych 
%          {y(x0), y'(x0), ...,y^(m-1)(x0)}
%
% Wyjście:
% - Y   - Macierz przybliżeń rozwiązania y i jej pochodncyh
%         w punktach xk (k = 0,1,...,n)
% - xk  - Wektor punktów, w których obliczono przybliżenia yk
% - y0  - Wektor przybliżeń rozwiązania y w punktach xk (k = 0,1,...,n)

ic = [a;ic];
m = length(ic);  % Rząd równania różniczkowego
h = (b - a) / n;  % Krok czasowy
xk = a:h:b;
Y = zeros(m, n+1);
Y(:, 1) = ic;  % Warunki początkowe


% Implementacja metody Rungego-Kutty 4-go rzędu (wzór "3/8") dla liniowego równania różniczkowego
    for k = 1:n
        k1 = h * F(xk(k), Y(:, k), fun);
        k2 = h * F(xk(k) + h/3, Y(:, k) + k1/3, fun);
        k3 = h * F(xk(k) + 2*h/3, Y(:, k) - k1/3 + k2, fun);
        k4 = h * F(xk(k) + h, Y(:, k) + k1 - k2 + k3, fun);
        
        Y(:, k+1) = Y(:, k) + (k1 + 3*k2 + 3*k3 + k4) / 8;
    end

y0 = Y(2,:);

end