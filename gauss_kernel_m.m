function current_val=gauss_kernel_m(inp_for_sys,cnt_MF)
    %encoding via gaussian convulution kernel
      %Normalising the features
    inp_for_sys=minmax(inp_for_sys,255,20);
    x=-360:0.1:360;
    mf_spiketime=cell(size(inp_for_sys,1),1);
    
    for loop_j=1:size(inp_for_sys,1)
        stor_sum_val=[];
        datapoints=zeros(1,cnt_MF);
        new_storing_mat=zeros(1,cnt_MF);
        mf_spike=cell(size(inp_for_sys,2),cnt_MF);
        
        for i=1:size(inp_for_sys,2)
            norm=normpdf(x,inp_for_sys(loop_j,i),10);
            inp_for_sys(loop_j,i);
            norm1=conv2(norm,inp_for_sys(loop_j,i));
            norm1=(norm1-min(norm1))/(max(norm1)-min(norm1));
            
            datapoints(i,:)=createneuron(inp_for_sys(loop_j,i),cnt_MF);
            wt=(inp_for_sys(loop_j,i)/3)*size(datapoints,2);
            
            l_dp=ismember(round(x,1),round(datapoints(i,:),1));
            find_dp=find(l_dp);
            stor_sum=wt*norm1(find_dp);
            try
                stor_sum_val=cat(1,stor_sum_val,stor_sum);
            catch
                stor_sum_val(:,end+1:size(stor_sum,2))=0;
                stor_sum_val=cat(1,stor_sum_val,stor_sum);
            end
            new_storing_mat=stor_sum_val;
        end
        current_val{loop_j}=new_storing_mat
    end