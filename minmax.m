function [arr]=minmax(data,newmax,newmin)
% Minmax normalisation for an array to a normalised value 

    arr=zeros(size(data));
    range=max(data)-min(data);
    %newmax=255;newmin=20;
    for i=1:size(data,1)
        for j=1:size(data,2)
            arr(i,j)=(data(i,j)-min(data(:,j)))/range(j);
            range2=newmax-newmin;
            arr(i,j)=(arr(i,j)*range2)+newmin;
        end
    end

end




        
