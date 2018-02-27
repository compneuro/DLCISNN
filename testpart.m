function [pre_mtr_angle,err]=testpart(testdata,testout,Goc_ob,Grc_ob,PC_ob)
%Function to predict class labels from a test data

    global wt_4_memoryconsolidated;
    
    %Encode test data into spike trains
    mf_spiketime=gauss_kernel(testout);
    
    for k=1:size(testdata,1)
        Goc_time=Goc_ob.Goc_time;
        [~,PC_input,~]=Grc_ob.Grc2PCinput(mf_spiketime{k},Goc_time);
        [PC_output,PC_time,PC_VV]=PC_ob.PCAdex(PC_input);
        PC_ob.PC_output=PC_output;
        PC_ob.PC_time=PC_time;
        PC_ob.PC_VV=PC_VV;
        temp=spik_cnt_calc(PC_time(1,:));
        [pre_mtr_angle(k,1),~,fwd{k,1}]=decoding(temp,testdata(k,1),2,...
            wt_4_memoryconsolidated{end}{1,3}{1,1},0); 
        err(k,1)=abs(testdata(k,1)- pre_mtr_angle(k,1));      
    end
    
end
