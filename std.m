clc
clear all
format short

C=[1, 2, -1] %cost coefficients
A=[1 -2 -3;2 3 -4;1 1 1] %coefficient Matrix
b=[4; 5; 2] %Right hand side

Ineqsign=[0 1 1];

i = eye(size(A, 1));
ind = find(Ineqsign > 0);
i(ind, :) = -i(ind, :)
A = [A i b]
obj = array2table(A)
obj.Properties.VariableNames(1:size(A,2))={'x_1','x_2','x_3','s1','s2','s3','b'}