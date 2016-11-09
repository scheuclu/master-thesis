function [ k ] = JacobiSolver( A,b,tol )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
D=diag(diag(A));
R=A-D;

x(:,1)=rand(4,1);

k=1;
  while norm(b - A*x(:,k))>tol

    x(:,k+1) = D\(b - R*x(:,k));
    k=k+1;
    
    if(k>10000)
      k=NaN;
      break
    end

  end

end

