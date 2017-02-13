function [new_accu, train_accu] = knn_classify(train_data, train_label, new_data, new_label, k)
% k-nearest neighbor classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%  k: number of nearest neighbors
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data (using leave-one-out
%  strategy)
%
% CS260, Homework 1

[N,D]=size(train_data);
unique_labels=unique(train_label);
count=0;
for i=1:N
    test_mat=repmat(train_data(i,:),N,1);
    dist_mat=(train_data-test_mat).^2;
    dist_array=sum(dist_mat,2);
    neighbours=linspace(1,N,N);
    [dist_array,neighbours]=sort(dist_array);
    dist=dist_array(1:k);
    neighbours=neighbours(1:k);
    class_count=zeros(size(unique_labels));
    for j=1:k
        class_index=neighbours(j);
        label_index=find(unique_labels==train_label(class_index));
        class_count(label_index)=class_count(label_index)+1;
    end;
    [~,result]=max(class_count);
    if (train_label(i)==unique_labels(result)) 
        count=count+1;
    end;
end;
train_accu=count/N;

count=0;
[M,~]=size(new_data);
for i=1:M
    test_mat=repmat(new_data(i,:),N,1);
    dist_mat=(train_data-test_mat).^2;
    dist_array=sum(dist_mat,2);
    neighbours=linspace(1,N,N);
    [dist_array,neighbours]=sort(dist_array);
    dist=dist_array(1:k);
    neighbours=neighbours(1:k);
    class_count=zeros(size(unique_labels));
    for j=1:k
        class_index=neighbours(j);
        label_index=find(unique_labels==train_label(class_index));
        class_count(label_index)=class_count(label_index)+1;
    end;
    [~,result]=max(class_count);
    if (new_label(i)==unique_labels(result)) 
        count=count+1;
    end;
end;
new_accu=count/M;

