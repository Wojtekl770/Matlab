function test3()
% Test 4: Test na funkcji wykładniczej
clc;
f = @(x) exp(x);
a = -10;
b = 30;
n = [9,11,13,15];
res = P1Z44_WLA_Gauss_Legendre(f,a,b,n);
expected_result = exp(30)-1/exp(10);
error = abs(res-expected_result);
rel_error = error./res;

% Tworzenie tablicy z danymi
data = [n', res, error, rel_error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), data(:,4),...
    'VariableNames', {'n', 'Actual_Result', 'Error', 'Relative_Error'});

disp('Test 4:');
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, dokładność oszacowań funkcji wykładniczej');
disp('w zależności od n ∈ {9,11,13,15}');
fprintf('Funkcja: f(x) = exp(x), na przedziale [-10, 30]\n');
fprintf('Expected Result:   %10.0f\n\n', expected_result);

% Zmiana formatu, by lepiej dostrzec różnice
format short;

% Wyświetlanie tabeli
disp(resultTable);
end