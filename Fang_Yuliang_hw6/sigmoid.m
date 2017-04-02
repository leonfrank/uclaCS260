function f=sigmoid(z)
f=1./(1.+exp(-z));
% f(f<1e-16)=1e-16;
% f(f>1-1e-16)=1-1e-16;
end