function [data_mean,data_std,data_scaled,label]=preprocess(filename)
    load(filename);
    
    data_mean=mean(data,1);
    
    data_std=std(data,1,1);
    
    data_scaled=zeros(size(data,1),size(data,2));
    
    for i=1:size(data,2)
        data_scaled(:,i)=(data(:,i)-data_mean(i))/data_std(i);
       
    end;
end