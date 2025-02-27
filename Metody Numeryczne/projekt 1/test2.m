function test2()
% Test 3: Test na funkcji trygonometrycznej
clc;
f = @(x) sin(x);
a = 0;
b = 7*pi;
n = [3,5,7,15];
res = P1Z44_WLA_Gauss_Legendre(f,a,b,n);
expected_result = 2;
error = abs(res-expected_result);

% Tworzenie tablicy z danymi
data = [n', res, error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), ...
    'VariableNames', {'n', 'Actual_Result', 'Error'});

disp('Test 3:')
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, dokładność oszacowań funkcji trygonometrycznej');
disp('w zależności od n ∈ {3,5,7,9}')
fprintf('Funkcja: f(x) = sin(x), na przedziale [0,7*pi]\n');
fprintf('Expected Result: %4.0f\n\n', expected_result);

% Zmiana formatu, by lepiej dostrzec różnice
format long;

% Wyświetlanie tabeli
disp(resultTable);
end
