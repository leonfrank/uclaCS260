function [train_accu,train_time]=linearSVM
[train_mean,train_std,train_scaled,train_label]=preprocess('splice_train.mat');
train_accu=zeros(9,1);
train_time=zeros(9,1);
for i=1:9
    C=4.^(i-7);
    option=['-t 0 -c ' num2str(C) ' -v 5'];
    tic
    model=svmtrain(train_label,train_scaled,option);
    train_accu(i)=model;
    train_time(i)=toc/5;
end;
end