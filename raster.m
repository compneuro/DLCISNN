function raster(spike_position)
dt=0:0.025:300;
figure()
cnt=0;
    for j=1:size(spike_position,2)
        for i=1:size(spike_position{j},1)
            spikePos=[];
            cnt=cnt+1;
            temp=find(spike_position{j}(i,:));
            for k=1:size(temp,2)
                spikePos(k)=find(dt==spike_position{j}(i,temp(k)));
            end
            for k=1:length(spikePos)
                %spikePos(k)=dt(1,spike_position{j}(i,temp(k)));
                plot([dt(spikePos(k)) dt(spikePos(k))],[cnt-0.4 cnt+0.4],'r');
                hold on
                %spike_positions(i,k)=spikePos(1,k);
            end
        end
    end
        
end