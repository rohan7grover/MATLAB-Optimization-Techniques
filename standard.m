%Standard form of the LPP
%Right hand side of the constraints must be positive
%All constraints must be of equality form
%All decision Variables must be non negative
% write the standard form of LPP
%Max z=x1+2x2-x3
%Subject to -x1+2x2+3x3>=-4
%2x1+3x2-4x3>=5
%x1+x2+x3>=2
%x1,x2,x3>=0
%change the first constraints as
%x1-2x2-3x3<=4
clc
clear all
format short
%Phase I: To input Parameters
C=[1, 2, -1] %cost coefficients
A=[1 -2 -3;2 3 -4;1 1 1] %coefficient Matrix
b=[4; 5; 2] %Right hand side
%Phase II: To identify <= or >= type constraints
% 0 for <= sign
% 1 for >= sign
Ineqsign=[0 1 1]
%Phase III: To introduce slack and surplus variables
s=eye(size(A,1))
index=find(Ineqsign>0) 
s(index,:)=-s(index,:)
%Phase IV: To write the standard form
objfn=array2table(C) %To representing objective function
objfn.Properties.VariableNames(1:size(C,2))={'x_1','x_2','x_3'}
mat=[A s b]
cons=array2table(mat);
cons.Properties.VariableNames(1:size(mat,2))={'x_1','x_2','x_3','s1','s2','s3','b'}