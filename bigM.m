% Big M method
clc
clear all
M=1000;
%---1---
% cost=[-3 -5 0 0 -M -M 0];
% a=[1 3 -1 0 1 0; 1 1 0 -1 0 1];
% b=[3;2];
% A=[a b];
% bv=[5 6];
% Var={'x1','x2','x3','s1','s2','s3',,'A1','A2','sol'};
% cost=[20 10 0 0 0 -M -M 0];
% a=[1 2 1 0 0 0 0;3 1 0 -1 0 1 0;4 3 0 0 -1 0 1];
% b=[40;30;60];
% artifical_var=[6 7];
% bv=[3 6 7];
% cost=[1 1 0 0 -M 0];
% a=[2 1 -1 0 1;1 7 0 1 0];
% b=[4;7];
% artifical_var=[5];
% bv=[4 5]; 
cost=[5 3 0 0 0 -M 0];
a=[1 1 1 0 0 0;5 2 0 1 0 0;2 8 0 0 -1 1];
b=[2;10;12];
artifical_var=[6];
bv=[3 4 6];
%----3---
% cost=[3 2 0 0 -M 0];
% artifical_var=5
% bv=[3 5];
% a=[2 1 1 0 0; 3 4 0 -1 1];
% b=[2;12];
A=[a b];
Var={'x1','x2','s1','s2','s3','A1','sol'};
% %----2--
% cost=[4 -3 0 0 -M -M 0];
% a=[2 1 -1 0 1 0; 2 -1 0 -1 0 1];
% b=[0;2];
% artifical_var=[5 6]
% A=[a,b];
% Var={'x1','x2','s1','s2','A1','A2','sol'};
% bv=[5 6];
zjcj=cost(bv)*A-cost;
% Display initial simplex table
simplex_table=[zjcj; A];
array2table(simplex_table,'VariableNames',Var)
RUN=true;
 while RUN
if any(zjcj(1:end-1)<0) % check for negative value
 fprintf(' The current BFS is not optimal \n');
 zc=zjcj(1:end-1);
 [Enter_val, pvt_col]= min(zc) ;
 if all(A(:,pvt_col)<=0)
  error('LPP is Unbounded');
 else
 sol=A(:,end);
 column=A(:,pvt_col);
  for i=1:size(A,1)
 if column(i)>0
 ratio(i)= sol (i)./column(i);
 else
 ratio(i)=inf;
 end
  end 
  [leaving_value,pvt_row]=min(ratio);
 end
 bv(pvt_row)=pvt_col;
 pvt_key=A(pvt_row, pvt_col);
 A(pvt_row,:)=A (pvt_row,:)./pvt_key;
 % row operation 
for i=1:size(A,1)
 if i~=pvt_row
 A(i,:)=A(i,:)-A (i, pvt_col).*A(pvt_row,:);
 end
end
 zjcj=cost(bv)*A-cost;
 next_table=[zjcj; A];
array2table(next_table,'VariableNames',Var)

else
    RUN=false;
    if any(bv==artifical_var(1))
        error('Infeasible solution');
    else
    fprintf('The table is optimal \n');
    end
    z=input(' Enter 0 for minimization and 1 for max \n');
   
    if z==0
        Obj_value=-zjcj(end);
    else
        Obj_value=zjcj(end);
    end
    fprintf('The final optimal value is % f \n',Obj_value);
end
 end