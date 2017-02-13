function [new_accu, train_accu] = naive_bayes(train_data, train_label, new_data, new_label)
% naive bayes classifier
% Input:
%  train_data: N*D matrix, each row as a sample and each column as a
%  feature
%  train_label: N*1 vector, each row as a label
%  new_data: M*D matrix, each row as a sample and each column as a
%  feature
%  new_label: M*1 vector, each row as a label
%
% Output:
%  new_accu: accuracy of classifying new_data
%  train_accu: accuracy of classifying train_data 
%
% CS260, Homework 2


[N,D]=size(train_data);
unique_labels=unique(train_label);

N_1=size(unique_labels,1);
p_train=zeros(N_1,1);
%the probability of labels and each condition probability 
for k=1:N_1
    p_train(k)=log(sum(train_label==unique_labels(k))/N);
    
end;%get the probability of every label;
count=0;
for i=1:N
    temp=p_train;
    for j=1:D % get the probability of each feature
          p_j=sum(train_data(:,j)==1);
          if (p_j==0) 
              continue;
          end;
          for k=1:N_1
             p_j=sum(train_data(:,j)==train_data(i,j)&train_label==unique_labels(k))/sum(train_label==unique_labels(k));
             temp(k)=temp(k)+log(p_j);
          end;
    end;
      
       
        
    [~,index]=max(temp);
    if unique_labels(index)==train_label(i)
        count=count+1;
    end;
end;
train_accu=count/N;

[N_2,D_2]=size(new_data);
count=0;
for i=1:N_2
    temp=p_train;
   for j=1:D_2 % get the probability of each feature
          p_j=sum(new_data(:,j)==1)/N;
          for k=1:N_1
              if (p_j==0&&new_data(i,j)~=0) 
                  p_j=0.1;
              else
                  p_j=sum(train_data(:,j)==new_data(i,j)&train_label==unique_labels(k))/sum(train_label==unique_labels(k));
              end;
                  temp(k)=temp(k)+log(p_j);
          end;
   end;
      
       
        
    [~,index]=max(temp);
    if unique_labels(index)==new_label(i)
        count=count+1;
    end;
end;
new_accu=count/N_2;




        
    
      
   
    
    
