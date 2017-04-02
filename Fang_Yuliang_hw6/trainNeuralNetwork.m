function [W1 W2] = trainNeuralNetwork( images, labels )
% Train Neural Network (1 Hidden Layer)
% Input:
% images: data matrix
% labels: labels vector/matrix
%
% Output:
% W1, W2: weights of the 1 hidden layer neural network
N_hid=100;
N_output=10;

[D1,D2,N]=size(images);
X=mapminmax(double(reshape(images,D1*D2,N))',0,1);

indices=crossvalind('Kfold',labels,5);
epsilon_init=0.12;
for t=1:5
    X_train=X(indices~=t,:);
    Y_train=labels(indices~=t);
    shuffle=randperm(size(X_train,1));
    X_train_shuffled=X_train(shuffle,:);
    Y_train_shuffled=Y_train(shuffle,:);
    W1=(rand(N_hid,D1*D2+1)*2*epsilon_init-epsilon_init)/5;
    W2=(rand(N_output,N_hid+1)*2*epsilon_init-epsilon_init);

    for i=1:size(X_train_shuffled,1)
        
        Y_target=zeros(10,1);
        Y_target(Y_train_shuffled(i)+1)=1;
        X_input=[1 X_train_shuffled(i,:)]';%785*1 vector
        X_output=W1*X_input; %100*1 vector
        X_hid=[1;tanh(X_output)]; %101*1 vector
        hid_output=W2*X_hid; %10*1 vector
        Y_output=sigmoid(hid_output);
        J=Y_target'*log(Y_output)+(1.-Y_target)'*(1.-log(Y_output));
                                                                                                            
%         J_p=-1./(Y_output);
%         J_p(Y_train_shuffled(i)+1)=1/Y_output(Y_train_shuffled(i)+1);
%         Delta_3=J_p.*Y_output.*(1.-Y_output);%10*1 vector
        Delta_3=Y_output-Y_target; 
        W2_grad=Delta_3*X_hid';%10*101 matrix
        sigma=W2'*Delta_3;%101*1 vector 
        Delta_2=(sigma(2:end)).*(1.-tanh(X_output).^2);
        W1_grad=Delta_2*X_input';%100*785 matrix
        W1=W1-W1_grad/(sqrt(i)*2); 
        W2=W2-W2_grad/(sqrt(i));
%         disp('Press a key!')
%         pause;
        
    end;
    
    disp('The test phase')
    
    X_test=X(indices==t,:);
    
    Y_test=labels(indices==t);
    X_test=[ones(size(X_test,1),1) X_test];
    h_test=X_test*W1';
    
    h_value=[ones(size(h_test,1),1) tanh(h_test)];
     
    test_output=sigmoid(h_value*W2');
   
    [~,Y_predict]=max(test_output,[],2);
    
    accu=mean(Y_predict-1==Y_test)
    pause;
end;
end