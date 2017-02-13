function [train_data,train_label,test_data,test_label,dict]=readSpam
train_spam=dir(['spam/train/spam/','*.txt']);
train_ham=dir(['spam/train/ham/','*.txt']);
test_spam=dir(['spam/test/spam/','*.txt']);
test_ham=dir(['spam/test/ham/','*.txt']);

f=fopen('spam/dic.dat','r');
dict=[];
 while ~feof(f)
      word=textscan(f,'%s',1,'delimiter','\n');
      dict=[dict;word];
      
 end
 dict=[dict{:}]';
train_spamfeatures=zeros(length(train_spam),size(dict,1));
for i=1:length(train_spam)
    f=fopen(['spam/train/spam/',train_spam(i).name],'r');
    while ~feof(f)
        tline=fgetl(f);
        strs=strsplit(tline);
        for j=1:length(strs)
            index=find(strcmpi(strs(j),dict));
            if (index~=0) train_spamfeatures(i,index)=train_spamfeatures(i,index)+1;
            end;
        end;
    end;
    fclose(f);
end;

train_hamfeatures=zeros(length(train_ham),size(dict,1));
for i=1:length(train_ham)
    f=fopen(['spam/train/ham/',train_ham(i).name],'r');
    while ~feof(f)
        tline=fgetl(f);
        strs=strsplit(tline);
        for j=1:length(strs)
            index=find(strcmpi(strs(j),dict));
            if (index~=0) train_hamfeatures(i,index)=train_hamfeatures(i,index)+1;
            end;
        end;
    end;
    fclose(f);
end;

test_spamfeatures=zeros(length(test_spam),size(dict,1));
for i=1:length(test_spam)
    f=fopen(['spam/test/spam/',test_spam(i).name],'r');
    while ~feof(f)
        tline=fgetl(f);
        strs=strsplit(tline);
        for j=1:length(strs)
            index=find(strcmpi(strs(j),dict));
            if (index~=0) test_spamfeatures(i,index)=test_spamfeatures(i,index)+1;
            end;
        end;
    end;
    fclose(f);
end;

test_hamfeatures=zeros(length(test_ham),size(dict,1));
for i=1:length(train_ham)
    f=fopen(['spam/test/ham/',test_ham(i).name],'r');
    while ~feof(f)
        tline=fgetl(f);
        strs=strsplit(tline);
        for j=1:length(strs)
            index=find(strcmpi(strs(j),dict));
            if (index~=0) test_hamfeatures(i,index)=test_hamfeatures(i,index)+1;
            end;
        end;
    end;
    fclose(f);
end;

train_data=[train_spamfeatures;train_hamfeatures];
train_label=[zeros(length(train_spam),1);ones(length(train_ham),1)];

test_data=[test_spamfeatures;test_hamfeatures];
test_label=[zeros(length(test_spam),1);ones(length(test_ham),1)];
end
    