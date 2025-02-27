function test01()
% Test 1: Test na funkcji wielomianowej
clc;
f = @(x) x.^29 + 3.*x.^15 - 6.*x.^8 + 21;
a = 0;
b = 1;
n = 15;
res = P1Z44_WLA_Gauss_Legendre(f,a,b,n);
expected_result = 4933/240;
error = abs(res-expected_result);

% Tworzenie tablicy z danymi
data = [n', res, error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), ...
    'VariableNames', {'n', 'Actual_Result', 'Error'});

disp('Test 1:');
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, czy oszacowanie kwadraturą zwróci');
disp('poprawny wynik funkcji wielomianowej');
fprintf('Funkcja: f(x) = x^29 + 3x^15 - 6x^8  + 21, na przedziale [0,1]\n');
fprintf('Expected Result:  %10.3f\n\n', expected_result);

% Zmiana formatu
format short;

% Wyświetlanie tabeli
disp(resultTable);
end
