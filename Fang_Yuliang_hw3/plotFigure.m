 function [w_iono,w_spam,w_iono_reg,w_spam_reg,w_iono_norm,w_spam_norm]=plotFigure
step_size=[0.001, 0.01, 0.05, 0.1, 0.5];
lambda=linspace(0,0.5,11);

[iono_train_data,iono_train_label]=readIono('ionosphere/ionosphere_train.dat');
[iono_test_data,iono_test_label]=readIono('ionosphere/ionosphere_test.dat');
[spam_train_data,spam_train_label,spam_test_data,spam_test_label,~]=readSpam;

w_iono=zeros(1,size(step_size,2));


for k=1:size(step_size,2)
    
[w_1,cross_entropy]=batch_grad(iono_train_data,iono_train_label,step_size(k),0);
w_iono(k)=sqrt(w_1'*w_1);
plot(linspace(1,50,50),cross_entropy,'o-');
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Cross Entropy of Ionosphere at step size = ',num2str(step_size(k))));
fig=gcf;
saveas(fig,strcat('ionosphere ',num2str(k)),'png');
close(fig);
hold off;
end;


w_spam=zeros(1,size(step_size,2));
for k=1:size(step_size,2)

[w_2,cross_entropy]=batch_grad(spam_train_data,spam_train_label,step_size(1,k),0);
plot(linspace(1,50,50),cross_entropy,'o-');
w_spam(k)=sqrt(w_2'*w_2);
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Cross Entropy of Spam Email at step size = ',num2str(step_size(k))))
fig=gcf;
saveas(fig,strcat('Spam ',num2str(k),'.png'));
hold on
end;

w_iono_reg=zeros(1,size(step_size,2));
for k=1:size(step_size,2)

[w_1,cross_entropy]=batch_grad(iono_train_data,iono_train_label,step_size(1,k),lambda(3));
w_iono_reg(k)=sqrt(w_1'*w_1);
plot(linspace(1,50,50),cross_entropy,'o-');
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Regularized Cross Entropy of Ionosphere at step size = ',num2str(step_size(k))))
fig=gcf;
saveas(fig,strcat('ionospherereg ',num2str(k)),'png');

close(fig);
end;

w_spam_reg=zeros(1,size(step_size,2));
for k=1:size(step_size,2)

[w_2,cross_entropy]=batch_grad(spam_train_data,spam_train_label,step_size(1,k),lambda(3));
w_spam_reg(k)=sqrt(w_2'*w_2);

plot(linspace(1,50,50),cross_entropy,'o-');
xlabel('Iteration times');
ylabel('Cross Entropy');
title(strcat('Regularized Cross Entropy of Spam Email at step size = ',num2str(step_size(k))))
fig=gcf;
saveas(fig,strcat('Spamreg ',num2str(k),'.png'));
close(fig);
end;

%--the l2 norm of w after updates 
w_spam_norm=zeros(size(lambda,1),1);
for j=1:size(lambda,2)
[w_1,cross_entropy]=batch_grad(spam_train_data,spam_train_label,step_size(2),lambda(j));
w_spam_norm(j)=sqrt(w_1'*w_1);
end;

w_iono_norm=zeros(size(lambda,1),1);

for j=1:size(lambda,2)
[w_1,cross_entropy]=batch_grad(iono_train_data,iono_train_label,step_size(2),lambda(j));
w_iono_norm(j)=sqrt(w_1'*w_1);
end;


%-- the cross entropy after 50 iterations in each dataset
if ~exist('Q4-c/Iono') 
    mkdir('Q4-c/Iono'); 
end;
if ~exist('Q4-c/Spam')
mkdir('Q4-c/Spam');
end;

for k=1:size(step_size,2)
    point=[];
for j=1:size(lambda,2)
  



[~,cost1]=batch_grad(iono_train_data,iono_train_label,step_size(1,k),lambda(j));
[~,cost2]=batch_grad(iono_test_data,iono_test_label,step_size(1,k),lambda(j));
point=[point;cost1(end),cost2(end)];
%w_iono(k)=sqrt(w_1'*w_1);
end;
plot(lambda,point(:,1),'ro-',lambda,point(:,2),'bs-');
xlabel('lambda');
ylabel('Cross Entropy');

ylim('auto');
legend('iono-train','iono-test');
title(strcat('Regularized Cross Entropy of Ionosphere at step size = ', num2str(step_size(k))));
fig=gcf;
saveas(fig,strcat('Q4-c/Iono/',num2str(k),'.png'));

hold off;
close(fig);
end;

for k=1:size(step_size,2)

   
point=[];
for j=1:size(lambda,2)
[~,cost1]=batch_grad(spam_train_data,spam_train_label,step_size(1,k),lambda(j));
[~,cost2]=batch_grad(spam_test_data,spam_test_label,step_size(1,k),lambda(j));
point=[point;cost1(end),cost2(end)];
%w_iono(k)=sqrt(w_1'*w_1);
end;

plot(lambda,point(:,1),'ro-',lambda,point(:,2),'bs-');
xlabel('step size');
ylabel('Cross Entropy');


legend('spam-train','spam-test');
title(strcat('Regularized Cross Entropy of Spam Email at step size = ', num2str(step_size(k))));
fig=gcf;
saveas(fig,strcat('Q4-c/Spam/',num2str(k),'.png'));

hold off;
close(fig);
end;

end

