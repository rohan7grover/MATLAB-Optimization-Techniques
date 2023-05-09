clc
clear all
% a: supply
% b: demand
% c: cost matrix
%c=[3 11 4 14 15;6 16 18 2 28;10 13 15 19 17;7 12 5 8 9];
% c=[2 3 11 7;1 0 6 1;5 8 15 9];
%  c=[2 10 4 5; 6 12 8 11;3 9 5 7];
c=[6 4 1 5;8 9 2 7;4 3 6 4]
a=[14 16 5] %row
b=[6 10 15 4] %col

% a=[15 25 10 15];
% b=[20 10 15 15 5];
% a=[6 1 10];
% b=[7 5 3 2];
% a=[12 25 20];
% b=[25 10 15 5];

if sum(a)==sum(b)
    fprintf('Given transportation problem is Balanced \n');
else
     fprintf('Given transportation problem is Unbalanced \n');
     if sum(a)<sum(b)
         c(end+1,:)=zeros(1,length(b))
         a(end+1)=sum(b)-sum(a)
     else
         c(:,end+1)=zeros(length(a),1)
         b(end+1)=sum(a)-sum(b)
     end
end

m=size(c,1);
n=size(c,2);
X=zeros(m,n);
ICost = c;

for i=1:m
   for j=1:n
        hh = min(c(:));
        [rowind, colind] = find(hh==c);
        x11 = min(a(rowind),b(colind));
        [val,ind]=max(x11);
        ii = rowind(ind);
        jj = colind(ind);
        y11 = min(a(ii), b(jj));
        X(ii, jj) = y11;
        a(ii) = a(ii) - y11;
        b(jj) = b(jj) - y11;
        c(ii, jj) = Inf;
   end
end

z = sum(sum(ICost.*X));
%fprintf('Initial BFS \n')
array2table(X)
fprintf('Transportation cost is %f \n',z);