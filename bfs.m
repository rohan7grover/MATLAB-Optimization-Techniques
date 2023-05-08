clc
clear all
A=[2 3 -1 4; 1 2 6 -7]; % write in standard form
C=[2 3 4 7];
b=[8; -3];
n = size(A,2)
m = size(A,1)
if n >= m
    nCm = nchoosek(n,m) %  Total no. of Basic solution
    p = nchoosek(1:n,m) % Pairs of basic solution
    sol=[]; % Default  solution is zero 
    for i=1:nCm 
        y=zeros(n,1);
        A1=A(:,p(i,:));
        X=inv(A1)*b;
        % Feasibility condition
        if all(X>=0 & X~=inf & X~=-inf)
            y(p(i,:))=X;
            sol=[sol y]
        end
    end
else 
    error('No of variables are less than constraints');
end
% Objective function
Z=C*sol;
% Find the optimal  value
[obj,index]=max(Z);
BFS=sol(:,index);
% Print the solution
optval=[BFS' obj];
array2table(optval,'VariableNames',{'x1','x2','x3','x4','z'})