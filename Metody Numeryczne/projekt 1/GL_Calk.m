function res = GL_Calk(f,a,b,n)
% Projekt 1, zadanie 44
% Wojciech Łapan, 327374
%
% Funkcja pomocnicza do obliczania całek f(x) na przedziale [a,b] n-punktową
% kwadraturą Gaussa-Legendre'a, gdzie n jest pojedyńczym punktem
% Wejście:
%   f   - uchwyt do funkcji ciągłej na [a,b] zwracającej wartości
%         rzeczywsite, której całka ma być przybliżona
%   a   - początek przedziału całkowania
%   b   - koniec przedziału całkowania
%         (przyjmujemy, że b jest większe od a)
%   n   - liczba punktów kwadratury Gaussa-Legendre'a,
%         
% Wyjście:
%   res - przybliżona wartość całki f(x)

% Obliczamy wartości i wagi dla kwadratury Gaussa-Legendre'a
% na przedziale [-1,1]
[wezl,wag] = GL_wezly(n);

% Przekszałcamy węzły na przedział [a, b]
wezl = ((b - a) / 2) * wezl + (a + b) / 2;

% Obliczamy wartość całki
res = (b - a) / 2 * sum(wag .* f(wezl));

end

