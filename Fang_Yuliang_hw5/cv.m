function [cv_accu,test_accu,train_time]=cv
[train_mean,train_std,train_scaled,train_label]=preprocess('splice_train.mat');
[test_mean,test_std,test_scaled,test_label]=preprocess('splice_test.mat');
indices=crossvalind('Kfold',train_label,5);
cv_accu=zeros(9,1);
test_accu=zeros(9,1);
train_time=zeros(9,1);
for i=1:9
    C=4.^(i-7);
    accu=0;
    tic
    for j=1:5
        cv_train_data=train_scaled(indices~=j,:);
        cv_train_label=train_label(indices~=j,:);
        cv_test_data=train_scaled(indices~=j,:);
        cv_test_label=train_label(indices~=j,:);
        [w,b]= trainsvm(cv_train_data, cv_train_label, C);
        accu=accu+testsvm(cv_test_data,cv_test_label,w,b);
    end;
    train_time(i)=toc;
    cv_accu(i)=accu/5;
end;

for i=1:9
[w,b]= trainsvm(train_scaled, train_label, 4.^(i-7));
test_accu(i)= testsvm(test_scaled,test_label,w,b);      
end;
end
        
    
