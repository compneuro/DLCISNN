function [Grc_ob,PC_ob,pre_mtr_angle,err_with_sign]=training(spike_positions,out,f,Goc_ob,Grc_ob,PC_ob,fwd)
    % Function for training the network with provided dataset
    
    global tot_wt;
    global motor_err;
    global it
    global wt_4_memoryconsolidated;

    for it=1:1
        it;
        for k=1:size(out,1)
            mf_spiketime=spike_positions{k};
            
            %Spike train updation with the new weights 
            if it==1
               [Grc_ob,PC_ob,PC_time]=create_network(mf_spiketime,size(out,...
                   2),f,1,Goc_ob,Grc_ob,PC_ob);
            else             
               [Grc_ob,PC_ob,PC_time]=create_network(mf_spiketime,size(out,...
                   2),f,motor_err{it}(k,:),Goc_ob,Grc_ob,PC_ob);
            end
            
            %Decoding spike trains after the updation 
            temp=spik_cnt_calc(PC_time(1,:));

            if it==1
                
                [pre_mtr_angle{1,it+1}(k,1),wt,fwd{1}{1}]=decoding(temp,out(k,1),...
                    it,wt_4_memoryconsolidated{it}{1,3}{1,1},1,fwd{1}{1});
            else
                [pre_mtr_angle{1,it+1}(k,1),wt,fwd{1}{1}]=decoding(temp,out(k,1),...
                    it,wt_4_memoryconsolidated{it}{1,3}{1,1},motor_err{it}(k,1),fwd{1}{1});
            end
            
            if (out(k,1)-pre_mtr_angle{1,it+1}(k,1))
                err_with_sign(k,1)=1;
            else
                err_with_sign(k,1)=0;
            end
            %err_with_sign(k,1)=out(k,1)-pre_mtr_angle{k}(1);
            motor_err{it+1}(k,1)=err_with_sign(k,1);
            tot_wt{3}{1,1}=wt;   
            wt_4_memoryconsolidated{it+1}=tot_wt;
            
        end
        
        tot=sum(abs(motor_err{end}));
 %       if(it==1||it==3||it==5||it==10||it==50)
            trainerrpercent=(tot/size(out,1))*100

            
  %      end
        if tot==0 
            break
        end
        
    end
end

