function result = F(x, Y, fun)
    % Funkcja opisująca liniowe równanie różniczkowe  
    m = length(Y);  % Rząd równania różniczkowego
    result = zeros(m, 1);
    for k = 1:m-1
        result(k) = Y(k+1);
    end
    
    % [b(x) - a0*Y(1) - a1*Y(2)...]/am
    eq = fun{end}(x);
    for k = 2:m
        eq = eq - fun{k}(x) * Y(m+2 - k);
    end
    eq = eq/fun{1}(x);

    result(m) = eq;

end
