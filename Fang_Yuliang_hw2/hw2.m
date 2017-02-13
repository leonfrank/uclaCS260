function fun=hw2
[train_data,train_label]=dataTransform('car_train.data');
[valid_data,valid_label]=dataTransform('car_valid.data');
[test_data,test_label]=dataTransform('car_test.data');

[nb_valid, nb_train]= naive_bayes(train_data,train_label,valid_data,valid_label);
[nb_test, nb_train]= naive_bayes(train_data,train_label,test_data,test_label);

train_data=train_data(:,(1:21));
valid_data=valid_data(:,(1:21));
test_data=test_data(:,(1:21));

gini_index=[];
for k=1:10
    treeclf=fitctree(train_data,train_label,'Prune','off','MinLeaf',k,'SplitCriterion','gdi');
    train_accu=sum(treeclf.predict(train_data)==train_label)/size(train_label,1);
    valid_accu=sum(treeclf.predict(valid_data)==valid_label)/size(valid_label,1);
    test_accu=sum(treeclf.predict(test_data)==test_label)/size(test_label,1);
    gini_index=[gini_index;[k,train_accu,valid_accu,test_accu]];
end;

cross_entropy=[];
for k=1:10
    treeclf=fitctree(train_data,train_label,'Prune','off','MinLeaf',k,'SplitCriterion','deviance');
    train_accu=sum(treeclf.predict(train_data)==train_label)/size(train_label,1);
    valid_accu=sum(treeclf.predict(valid_data)==valid_label)/size(valid_label,1);
    test_accu=sum(treeclf.predict(test_data)==test_label)/size(test_label,1);
    cross_entropy=[cross_entropy;[k,train_accu,valid_accu,test_accu]];
end;

knn=[];
for k=1:2:23
[valid_accu,train_accu]=knn_classify(train_data,train_label,valid_data,valid_label,k);
[test_accu,train_accu]=knn_classify(train_data,train_label,test_data,test_label,k);
knn=[knn;[k,train_accu,valid_accu,test_accu]];
end;

mnclf=mnrfit(train_data,train_label);

end

