function [cv_accu,poly_time]=polySVM;
[train_mean,train_std,train_scaled,train_label]=preprocess('splice_train.mat');
cv_accu=zeros(9,3);
poly_time=zeros(9,3);

for i=1:12
    C=4.^(i-5);
    for j=1:3
    option=['-t 1 -d ' num2str(j) ' -c ' num2str(C) ' -v 5'];
    tic
    model=svmtrain(train_label,train_scaled,option);
    cv_accu(i,j)=model;
    poly_time(i,j)=toc/5;
    end;
end;
end