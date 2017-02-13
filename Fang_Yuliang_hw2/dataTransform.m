function [matrix_binary,label_binary] = dataTransform(filename)
file = fopen(filename);
A = textscan(file,'%s%s%s%s%s%s%s','delimiter', ',');
n = size(A{1,1},1);

label_binary = ones(n,1);
matrix_binary=zeros(n,27);

for i = 1:n
    %transform buying: vhigh, high, med, low. 
    
    if strcmp(A{1,1}{i,1},'vhigh')
        matrix_binary(i,1)=1;
    elseif strcmp(A{1,1}{i,1},'high')
        matrix_binary(i,2)=1;
    elseif strcmp(A{1,1}{i,1},'med')
        matrix_binary(i,3)=1;
    elseif strcmp(A{1,1}{i,1},'low')
        matrix_binary(i,4)=1;
    else
        matrix_binary(i,22)=-1;
    end;
    
    %transform maint: vhigh, high, med, low.  
    if strcmp(A{1,2}{i,1},'vhigh')
        matrix_binary(i,5)=1;
    elseif strcmp(A{1,2}{i,1},'high')
        matrix_binary(i,6)=1;
    elseif strcmp(A{1,2}{i,1},'med')
        matrix_binary(i,7)=1;
    elseif strcmp(A{1,2}{i,1},'low')
        matrix_binary(i,8)=1;
    else 
        matrix_binary(i,23)=-1;
    end;
    
    %transform doors: 2, 3, 4, 5more. 
    if strcmp(A{1,3}{i,1},'2')
        matrix_binary(i,9)=1;
    elseif strcmp(A{1,3}{i,1},'3')
        matrix_binary(i,10)=1;
    elseif strcmp(A{1,3}{i,1},'4')
        matrix_binary(i,11)=1;
    elseif strcmp(A{1,3}{i,1},'5more')
        matrix_binary(i,12)=1;
    else matrix_binary(i,24)=-1;
    end;
    
    %transform persons: 2, 4, more. 
    if strcmp(A{1,4}{i,1},'2')
        matrix_binary(i,13)=1;
    elseif strcmp(A{1,4}{i,1},'4')
        matrix_binary(i,14)=1;
    elseif strcmp(A{1,4}{i,1},'more')
        matrix_binary(i,15)=1;
    else matrix_binary(i,25)=-1;
    end;
    
    %transform lug_boot: small, med, big. 
     if strcmp(A{1,5}{i,1},'small')
        matrix_binary(i,16)=1;
    elseif strcmp(A{1,5}{i,1},'med')
        matrix_binary(i,17)=1;
     elseif strcmp(A{1,5}{i,1},'big')
        matrix_binary(i,18)=1;
     else matrix_binary(i,26)=-1;
     end;
    %transform safety: low, med, high. 
    if strcmp(A{1,6}{i,1},'low')
        matrix_binary(i,19)=1;
    elseif strcmp(A{1,6}{i,1},'med')
        matrix_binary(i,20)=1;
    elseif strcmp(A{1,6}{i,1},'high')
        matrix_binary(i,21)=1;
        else matrix_binary(i,27)=-1;
    end;
    % if there are new feature values, we put them in the latter column.
    %transform Class Values: unacc, acc, good, vgood 
    if strcmp(A{1,7}{i,1},'unacc')
        label_binary(i,1)=1;
    elseif strcmp(A{1,7}{i,1},'acc')
        label_binary(i,1)=2;
    elseif strcmp(A{1,7}{i,1},'good')
        label_binary(i,1)=3;
    elseif strcmp(A{1,7}{i,1},'vgood')
        label_binary(i,1)=4;
    
    end;
    
end;
end