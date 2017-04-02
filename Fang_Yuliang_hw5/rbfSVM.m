function [rbf_accu,rbf_time]=rbfSVM
[train_mean,train_std,train_scaled,train_label]=preprocess('splice_train.mat');
rbf_accu=zeros(9,10);
rbf_time=zeros(9,10);
for i=1:12
    C=4.^(i-5);
    for j=1:10
    gamma=4.^(j-8);
    option=['-t 2 -g ' num2str(gamma) ' -c ' num2str(C) ' -v 5'];
    tic
    model=svmtrain(train_label,train_scaled,option);
    rbf_accu(i,j)=model;
    rbf_time(i,j)=toc/5;
    end;
end;
end