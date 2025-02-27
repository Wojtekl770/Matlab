function res = P1Z44_WLA_Gauss_Legendre(f,a,b,n)
% Projekt 1, zadanie 44
% Wojciech Łapan, 327374
%
% Obliczanie całek f(x) na przedziale [a,b] n-punktową
% kwadraturą Gaussa-Legendre'a (n = 3,5,7,9,11,13,15)
% Wejście:
%   f   - uchwyt do funkcji ciągłej na [a,b] zwracającej wartości
%         rzeczywsite, której całka ma być przybliżona
%   a   - początek przedziału całkowania
%   b   - koniec przedziału całkowania
%         (przyjmujemy, że b jest większe od a)
%   n   - wektor z liczbami punktów kwadratury Gaussa-Legendre'a,
%         
% Wyjście:
%   res - wektor przybliżonych wartośi całki dla poszczególnych n

% Przygotowujemy wektor res, by nie zmieniać go w każdej iteracji
nlen = length(n);
res = zeros(nlen,1);

% Obliczamy osobno metodą GL_Calk całkę z f(x) dla pojedyńczego n(i)
for i = 1:nlen
    res(i) = GL_Calk(f,a,b,n(i));
end

