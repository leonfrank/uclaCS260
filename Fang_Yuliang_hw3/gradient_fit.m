function [J,grad]=gradient_fit(X,y,w,lambda)



J=-(y'*log(sigmoid(X*w)))-((1.-y)'*log(1.-sigmoid(X*w)))+lambda*w(2:end)'*w(2:end);
grad=(X'*(sigmoid(X*w)-y))+[0;2*lambda*w(2:end)];

end