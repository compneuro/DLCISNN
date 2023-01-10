function [timeser]=spiktime2matrix(spike_positions)
cnt=0;
timeser=[];
%cell array of spiketiming is stored in a matrix timeser
    for j=1:length(spike_positions)
        for i=1:size(spike_positions{j},1)
            cnt=cnt+1;
            I=find(spike_positions{j}(i,:));
            if(isempty(I))
                timeser(cnt,1:end)=0;
            else
                for k=1:I(end)
                    timeser(cnt,k)=spike_positions{j}(i,k);
                end
            end
        end
    end
end