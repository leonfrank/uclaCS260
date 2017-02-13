function [cross_entropy,w]=newton_plot(train_data,train_label,lambda)

%step_size=[0.001, 0.01, 0.05, 0.1, 0.5];


% [iono_train_data,iono_train_label]=readIono('ionosphere/ionosphere_train.dat');
% [iono_test_data,iono_test_label]=readIono('ionosphere/ionosphere_test.dat');
% [spam_train_data,spam_train_label,spam_test_data,spam_test_label,~]=readSpam;
% iono_cost=[];
[N,~]=size(train_data);
w=[0.1;zeros(size(train_data,2),1)];
train_data=[ones(N,1),train_data];


% size(w)
% size(train_data)
cross_entropy=zeros(50,1);
for k=1:50
    [cost,H,H_b,grad]=newton(train_data,train_label,w,lambda);
    cross_entropy(k)=cost;
    w(2:end)=w(2:end)-pinv(H)*grad(2:end)/N;
    w(1)=w(1)-(grad(1)/H_b)/N;
end;

    