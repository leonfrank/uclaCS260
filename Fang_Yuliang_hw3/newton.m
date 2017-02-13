function [J,H,H_b,grad]=newton(X,y,w,lambda)
J=-(y'*log(sigmoid(X*w)))-((1.-y)'*log(1.-sigmoid(X*w)))+lambda*w(2:end)'*w(2:end);
H=zeros(size(X,2)-1,size(X,2)-1);

grad=(X'*(sigmoid(X*w)-y))+[0;2*lambda*w(2:end)];
for i=1:size(H,1)
    for j=1:size(H,2)
    H(i,j)=X(:,i+1)'*(sigmoid(X*w).*(1.-sigmoid(X*w)).*X(:,j+1));
    end;
end;
I=eye(size(H,1));
H=H+lambda*I;
H_b=(X'*sigmoid(X*w))'*(X'*(1.-sigmoid(X*w)));
end
