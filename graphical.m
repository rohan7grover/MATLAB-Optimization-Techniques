clc
clear all
format short
%% phase 1: input parameter
C=[3 5];
A=[1 2; 1 1; 0 1];
b=[2000; 1500; 600];
%% phase 2: plotting the graph
y1=0:100:max(b);
x21=(b(1)-A(1,1).*y1)./A(1,2);
x22=(b(2)-A(2,1).*y1)./A(2,2);
x23=(b(3)-A(3,1).*y1)./A(3,2);
x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
plot(y1, x21, 'r', y1, x22, 'k', y1, x23, 'b')
xlabel('values of x1')
ylabel('values of x2')
title('x1 vs x2')
legend('x1+2x2=2000','x1+x2=1500','x2=600')
grid on
%% phase 3: find corner points with axes
cx1=find(y1==0);    %%points with x1 axis this line is fix
c1=find(x21==0);    %%points with x2 axis for first line
Line1=[y1([c1 cx1]); x21([c1 cx1])]'; 
c2=find(x22==0);    %%points with x2 axis for second line
Line2=[y1([c2 cx1]); x22([c2 cx1])]'; 
c3=find(x23==0);     %%points with x2 axis for third line
Line3=[y1([c3 cx1]); x23([c3 cx1])]'; 
corpt=unique([Line1; Line2; Line3], 'rows');   % unique for no repetation of points
%% phase 4: points of intersection
pt=[0; 0];
for i=1:size(A,1)   % all constraint=3 so we can write size(A,1)
    for j=i+1:size(A,1)   
        A1=A([i j],:);   
        B1=b([i j]);
        x=inv(A1)*B1;
        pt=[pt x];
    end
end
ptt=pt'
%% phase 5: all corner points
allpt=[ptt; corpt];
points=unique(allpt, 'rows');
%% phase 6: Feasible region
for i=1:size(points,1)
    const1 (i) = A(1,1) * points(i,1) + A(1,2) * points(i,2) - b(1);
    const2 (i) = A(2,1) * points(i,1) + A(2,2) * points(i,2) - b(2);
    const3 (i) = A(3,1) * points(i,1) + A(3,2) * points(i,2) - b(3);
    s1=find(const1>0);
    s2=find(const2>0);
    s3=find(const3>0);
end
S=unique([s1 s2 s3]);
points(S, :)=[];
%% phase 7: objective value and points
value=points*C';
table=[points value];
[obj, index]=max(value);
X1=points(index,1);
X2=points(index,2);
fprintf('objective value is %f at (%f,%f)', obj, X1, X2);