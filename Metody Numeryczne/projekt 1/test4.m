function test4()
% Test 5: Test na funkcji dążącej do nieskończoności
clc;
f = @(x) 1./(sqrt(1-x.*x));
a = -1;
b = 1;
n = [3,7,11,15];
res = P1Z44_WLA_Gauss_Legendre(f, a,b,n);
expected_result = pi;
error = abs(res-expected_result);

% Tworzenie tablicy z danymi
data = [n', res, error];

% Tworzenie tabeli
resultTable = table(data(:,1), data(:,2), data(:,3), ...
    'VariableNames', {'n', 'Actual_Result', 'Error'});

disp('Test 5:');
disp('-----------------------------------------------------------------');
disp('Sprawdzamy, jak funkcja radzi sobie z wartościami dążącymi do');
disp('nieskończoności, na krańcach przedziału [a,b]');
fprintf('Funkcja: f(x) = 1/sqrt(1-x%c), na przedziale [-1, 1]\n',char(178));
fprintf('Expected Result:   %15.15f (%c)\n\n', expected_result, char(960));

% Zmiana formatu, by lepiej dostrzec różnice
format long;

% Wyświetlanie tabeli
disp(resultTable);
end
