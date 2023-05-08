clc
clear all
format short
%%
C=[3 5];
A=[1 2; 1 1; 0 1];
b=[2000; 1500; 600];
%%
y1 = 0:1:max(b);
x21=(b(1)-A(1,1).*y1)./A(1,2);
x22=(b(2)-A(2,1).*y1)./A(2,2);
x23=(b(3)-A(3,1).*y1)./A(3,2);

x21=max(0,x21);
x22=max(0,x22);
x23=max(0,x23);
plot(y1, x21, 'r', y1, x22, 'k', y1, x23, 'b')
%%
cx1=find(y1==0);  
c1=find(x21==0);
Line1=[y1([c1 cx1]); x21([c1 cx1])]'; 
c2=find(x22==0);    
Line2=[y1([c2 cx1]); x22([c2 cx1])]'; 
c3=find(x23==0);     
Line3=[y1([c3 cx1]); x23([c3 cx1])]'; 
cpts = unique([Line1 ; Line2 ; Line3], 'rows');
%%
pts = [0 0];
for i = 1 : size(A, 1)
    for j = i + 1 : size(A, 1)
        A1 = A([i j], :);
        b1 = b([i j]);
        x = inv(A1)*b1;
        pts = [pts ; x'];
    end
end
allpts = [cpts ; pts];
points = unique(allpts, 'rows');
%%
for i = 1 : size(points,1)
    const1 (i) = A(1,1)*points(i, 1) + A(1,2) * points(i, 2) - b(1);
    const2 (i) = A(2,1)*points(i,1) + A(2,2) * points(i,2) - b(2);
    const3 (i) = A(3,1)*points(i,1) + A(3,2) * points(i,2) - b(3);
end
s1=find(const1>0);
s2=find(const2>0);
s3=find(const3>0);
S=unique([s1 s2 s3]);
points(S, :)=[];
%%
value = points*C';
table=[points value];
[obj, index] = max(value);
ans = table(index, :)