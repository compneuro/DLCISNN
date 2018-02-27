function spike_count=spik_cnt_calc(obtained)
%Calculating the number of spikes in a trace

    timespan=300;
    bin_dt=50;
    spike_count=zeros(1,timespan/bin_dt);
    cntr=0;
    
    for i=1:bin_dt:timespan
        cntr=cntr+1;
        A=size(find(obtained<=i),2);
        B=size(find(obtained<=i+bin_dt),2);
        spike_count(1,cntr)=B-A;
    end
end
            
        
