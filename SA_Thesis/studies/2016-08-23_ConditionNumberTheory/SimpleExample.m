clear
close all
clc





A=[...
  3 1 1 1 
  1 2 1 1
  1 2 3 2
  1 1 1 4]

b=[...
  1
  1
  2
  2]






% A\b
% 
% 
Anew=A
bnew=b
Anew(1,:)=Anew(1,:)*1e-8
bnew(1,:)=bnew(1,:)*1e-8

Anew\bnew;

cond(A)
cond(Anew)

JacobiSolver( A,b,1e-6 )
JacobiSolver( Anew,bnew,1e-6 )