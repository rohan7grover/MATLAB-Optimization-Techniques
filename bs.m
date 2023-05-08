clc
clear all
A=[2 3 -1 4; 1 2 6 -7]; % write in standard form
C=[2 3 4 7];
b=[8; -3];
n = size(A,2);
m = size(A,1);
sol = [];
if n >= m
    nCm = nchoosek(n,m);
    p = nchoosek(1:n, m);
    for i = 1 : nCm
        y = zeros(n, 1);
        A1 = A(:, p(i, :));
        x = inv(A1)*b;
        if all(x >= 0 & x ~= inf & x ~= -inf)
            y(p(i, :)) = x;
            sol = [sol y];
        end
    end
else
    error("fuck you");
end