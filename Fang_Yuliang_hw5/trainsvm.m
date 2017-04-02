function [w,b] = trainsvm(train_data, train_label, C)
% Train linear SVM (primal form)
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  C: tradeoff parameter (on slack variable side)
%
% Output:
%  w: feature vector (column vector)
%  b: bias term
%
[N,D]=size(train_data);
H=0.5*diag([ones(1,D),zeros(1,N+1)]);
A1=zeros(N,D);
for i=1:N
    A1(i,:)=train_data(i,:)*train_label(i);
end;
Aineq=-[A1 eye(N) train_label];
bineq=-ones(N,1);
F=[zeros(D,1);C*ones(N,1);0];
lb=[-Inf(D,1);zeros(N,1);-Inf];
[x,fval,exitflag,output,lambda]=quadprog(H,F,Aineq,bineq,[],[],lb);
w=x(1:D);
b=w(end);
end
