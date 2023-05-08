clc
clear all
cost = [2 1 0 0 0 0];
a = [1 2 1 0 0 ; 1 1 0 1 0 ; 1 -1 0 0 1];
b = [10 ; 6 ; 2];
A = [a b];
bv = [3 4 5]; 
zjcj = cost(bv)*A-cost;
run = true;
while run
    if any(zjcj(1 : end-1) < 0)
        fprintf('this is not our optimal table');
        [val, pvt_col] = min(zjcj(1 : end-1));
        if all(A(:, pvt_col) <= 0)
            fprintf('lpp is unbounded');
        else
            sol = A(:, end);
            for i = 1 : size(A, 1)
                if A(i, pvt_col) > 0
                    ratio(i) = sol(i) ./ A(i, pvt_col); 
                else
                    ratio(i) = inf;
                end
            end
            [val, pvt_row] = min(ratio);
        end
        bv(pvt_row) = pvt_col;
        pvt_element = A(pvt_row, pvt_col);
        A(pvt_row, :) = A(pvt_row, :) ./ pvt_element;
        for i = 1 : size(A, 1)
            if i ~= pvt_row
                A(i, :) = A(i, :) - A(i, pvt_col) .* A(pvt_row, :);
            end
        end
        zjcj = zjcj - zjcj(pvt_col) .* A(pvt_row, :);
    else
        run = false;
        fprintf('this is our optimal table %f', zjcj(end));
    end
end