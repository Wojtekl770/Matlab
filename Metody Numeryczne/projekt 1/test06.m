function test06()
% Test 6: Test na wzór oszacowania blędu
clc;
f = @(x) cos(x);
a = 0;
b = 2.5*pi;
n = [3,5];
res = P1Z44_WLA_Gauss_Legendre(f, a,b,n);
expected_result = 1;
error = abs(res-expected_result);
min_error = [0 ; 0];
max_error = [420/21; 20];

% Tworzenie tablicy z danymi
data = [n', res, min_error, error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), data(:,4),...
    'VariableNames', {'n', 'Actual_Result','Minimal_Error', 'Error'});

disp('Test 5:');
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, czy obliczony błąd funkcji jest zgodny, ze wzorem');
disp('na oszacowanie potencjalnego błędu');
fprintf('I(f) - Gn(f) = f''(2n+2)(E) / (2n+2)! *  \x222B(b,a) w(x) ');
fprintf('(%s(n+1)(x)%c) dx, gdzie\n', char(966),char(178));
fprintf('   I(f) - wynik całki\n   Gn(f) - przybliżenie całki n+1 punktową')
fprintf([' kwadraturą Gaussa\n   w(x) - funkcja wagowa' ...
    '(równa 1 dla Legendre''a)\n   %s(x) '],char(966))
fprintf('= (x − x0)(x − x1)···(x − xn)\n   dla pewnego E ∈ (a,b)\n')
fprintf('Funkcja: f(x) = cos(x), na przedziale [0, 2.5*pi]\n');
fprintf('Expected Result:   %15.15f\n\n', expected_result);

% Zmiana formatu, by lepiej dostrzec różnice
format long;

% Wyświetlanie tabeli
disp(resultTable);
end
