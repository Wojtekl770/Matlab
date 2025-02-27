function err = zad3(y1, y2, y_vec, h)
    t = 0:h:8;
    err(1) = sum((y1(t) - y_vec(1, :)).^2) / (sum(y1(t)).^2);
    err(2) = sum((y2(t) - y_vec(1, :)).^2) / (sum(y2(t)).^2);
end
