function [train_accu,test_accu]=CS260_hw6
load('train.mat');
N_hid=100;
N_output=10;

[D1,D2,N]=size(train.images);
X_train=mapminmax(double(reshape(train.images,D1*D2,N))',0,1);
Y_train=train.labels;
epsilon_init=0.12;
iter_accu=zeros(N,1);
    shuffle=randperm(size(X_train,1));
    X_train_shuffled=X_train(shuffle,:);
    Y_train_shuffled=Y_train(shuffle,:);
    W1=(rand(N_hid,D1*D2+1)*2*epsilon_init-epsilon_init)/5;
    W2=(rand(N_output,N_hid+1)*2*epsilon_init-epsilon_init);
    train_accu=zeros(size(X_train,1),1);
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
		iter_accu(i)=testNeuralNetwork(train.images,train.labels,W1,W2);
       
    end; 
	plot(iter_accu);
	title('training accuracy vs iterations');
    train_accu=testNeuralNetwork(train.images,train.labels,W1,W2);
	load('test.mat');
	test_accu=testNeuralNetwork(test.images,test.labels,W1,W2);
end