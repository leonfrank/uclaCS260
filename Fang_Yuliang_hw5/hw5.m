function [poly,rbf]=hw5
[train_mean,train_std,train_scaled,train_label]=preprocess('splice_train.mat');
[test_mean,test_std,test_scaled,test_label]=preprocess('splice_test.mat');
poly_option='-t 1 -d 1 -c 1'; 
poly_model=svmtrain(train_label,train_scaled,poly_option);
[poly_predict,poly,poly_decision_values]=svmpredict(test_label,test_scaled,poly_model);
rbf_option=['-t 2 -g ' num2str(4.^(-3)) ' -c 4'];
rbf_model=svmtrain(train_label,train_scaled,rbf_option);
[rbf_predict,rbf,rbf_decision_values]=svmpredict(test_label,test_scaled,rbf_model);
end
