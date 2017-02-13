function [w,test_cost,w_iono,w_spam,w_iono_reg,w_spam_reg,w_iono_lambda, w_spam_lambda]=CS260_hw3

[iono_train_data,iono_train_label]=readIono('ionosphere/ionosphere_train.dat');
[iono_test_data,iono_test_label]=readIono('ionosphere/ionosphere_test.dat');
[spam_train_data,spam_train_label,spam_test_data,spam_test_label,dict]=readSpam;

word_count=sum(spam_train_data,1);
[B,I]=sort(word_count);

dict(I(end-2:end))
B(end-2:end)

[w_iono,w_spam,w_iono_reg,w_spam_reg,w_iono_lambda, w_spam_lambda]=plotFigure

lambda=linspace(0,0.5,11);
test_cost=[];
w=[];
if ~exist('newton') 
    mkdir('newton');
end;
if ~exist('newton/iono') 
    mkdir('newton/iono');
end;
if ~exist('newton/spam') 
    mkdir('newton/spam');
end;
for k=1:size(lambda,2)
    

[iono_cost,w_1]=newton_plot(iono_train_data,iono_train_label,lambda(k));
w_iono=sqrt(w_1'*w_1);

plot(linspace(1,50,50),iono_cost,'ro-');
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Newton method for Ionosphere dataset lambda = ',num2str(lambda(k))));
fig=gcf;
saveas(fig,strcat('newton/iono/',num2str(k),'.png'));
close(fig);


[spam_cost,w_2]=newton_plot(spam_train_data,spam_train_label,lambda(k));
w_spam=sqrt(w_2'*w_2);

plot(linspace(1,50,50),spam_cost,'ro-');
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Newton method for Spam Email dataset lambda = ',num2str(lambda(k))));
fig=gcf;
saveas(fig,strcat('newton/spam/',num2str(k),'.png'));
close(fig);
[iono_test_cost,~]=newton_plot(iono_test_data,iono_test_label,lambda(k));
[spam_test_cost,~]=newton_plot(spam_test_data,spam_test_label,lambda(k));
test_cost=[test_cost;[iono_test_cost(end),spam_test_cost(end)]];
w=[w;[w_iono,w_spam]];
end;
end
