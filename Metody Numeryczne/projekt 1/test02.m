function test02()
% Test 2: Test, czy funkcja spełnia założenia dokładności Gaussa-Legendre'a
clc;
f = @(x) x.^9;
a = 0;
b = 1;
n = [3, 5, 7];
res = P1Z44_WLA_Gauss_Legendre(f,a,b,n);
expected_result = 0.1;
error = abs(res-expected_result);

% Tworzenie tablicy z danymi
data = [n', res, error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), ...
    'VariableNames', {'n', 'Actual_Result', 'Error'});

disp('Test 2:');
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, czy oszacowanie jest dokładne dla wielomianów do');
disp('stopnia 2n-1, zgodnie z założeniami kwadratury Gaussa-Legendre''a');
fprintf('Funkcja: f(x) = x%c, na przedziale [0,1]\n', char(8313));
fprintf('Expected Result:  %6.1f\n\n', expected_result);

% Zmiana formatu
format short;

% Wyświetlanie tabeli
disp(resultTable);
end
