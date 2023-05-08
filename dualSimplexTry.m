clc
clear all
format short
cost = [-2, 0, -1, 0, 0, 0];
a = [-1, -1, 1, 0, 0 ; -1, 2, -4, 0, 1];
b= [-5; -8];
A = [a b];
bv = [4, 5];
zjcj = cost(bv)*A - cost;

run = true;
while run
    if any(A(:, end) < 0)
        fprintf('the solution is not feasible \n');
        [val, pivot_row] = min(A(:, end));
        row = A(pivot_row, 1 : end - 1);
        zrow = zjcj(1 : end - 1);
        for i = 1 : size(row, 2)
            if row(i) < 0
                ratio(i) = abs(zrow(i) ./ row(i));
            else
                ratio(i) = inf;
            end
        end   
        [val, pivot_col] = min(ratio);
        bv(pivot_row) = pivot_col;
        pivot_element = A(pivot_row, pivot_col);
        A(pivot_row, :) = A(pivot_row, :) ./ pivot_element;
        for i = 1 : size(A, 1)
            if i ~= pivot_row
                A(i, :) = A(i, :) - A(i, pivot_col) .* A(pivot_row, :);
            end
        end
        zjcj = zjcj - zjcj(pivot_col) .* A(pivot_row, :);
    else
        run = false;
        fprintf('The current BFS is Feasible and Optimal \n');
    end
end

final_bfs = zeros(1,size(A, 2) - 1);
final_bfs(bv) = A(:, end)
final_optimal_sol = zjcj(end)



