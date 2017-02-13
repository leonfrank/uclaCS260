function [w,cross_entropy]=batch_grad(train_data,train_label,step_size,lambda)

%[test_data,test_label]=readIono('ionosphere/ionosphere_test.dat');

[N,D]=size(train_data);
train_data=[ones(N,1),train_data];
%test_data=[ones(size(test_data,1),1),test_data];


    w=[0.1;zeros(D,1)];
    cross_entropy=[];
    fig=figure;
for i=1:50
    [cost,grad]=gradient_fit(train_data,train_label,w,lambda);
    cross_entropy=[cross_entropy;cost];
    w=w-step_size*grad/N;
end

end
    
    
