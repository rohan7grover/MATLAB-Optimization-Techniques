clc
clear all
format short

c = [6 4 1 5 ; 8 9 2 7 ; 4 3 6 4]
a = [14 16 5] %row
b = [6 10 15 4] %col

if sum(a) == sum(b)
    fprintf('it is balanced \n');
else
    fprintf('it is not balanced \n');
    if sum(a) < sum(b)
        c(end+1, :) = zeros(1, length(b));
        a(end+1) = sum(b) - sum(a);
    else
        c(:, end+1) = zeros(length(a), 1);
        b(end+1) = sum(a) - sum(b);    
    end
end

m = size(c, 1);
n = size(c, 2);
Icost = c;
X = zeros(m, n);

for i = 1 : m
    for j = 1 : n
         hh = min(c(:));
         [rowind, colind] = find(hh == c);
         x11 = min(a(rowind), b(colind));
         [val, ind] = max(x11);
         ii = rowind(ind);
         jj = colind(ind);
         y11 = min(a(ii), b(jj));
         X(ii, jj) = y11;
         a(ii) = a(ii) - y11;
         b(jj) = b(jj) - y11;
         c(ii, jj) = inf;
    end
end

z = sum(sum(Icost.*X)) 

