function [ acc ] = testNeuralNetwork(images, labels, W1, W2)
% Test Neural Network (1 Hidden Layer)
% Input:
% images: data matrix
% labels: labels vector/matrix
% W1, W2: weights of the 1 hidden layer neural network
%
% Output:
% acc: accuracy of the neural network for the dataset
[D1,D2,N]=size(images);
X_test=mapminmax(double(reshape(images,D1*D2,N)'),0,1);
Y_test=labels;
X_test=[ones(size(X_test,1),1) X_test];
    h_test=X_test*W1';
    
    h_value=[ones(size(h_test,1),1) tanh(h_test)];
     
    test_output=sigmoid(h_value*W2');
   
    [~,Y_predict]=max(test_output,[],2);
    
    acc=mean(Y_predict-1==Y_test);
end