function [final,weight,fwd]=decoding(n_inp,dset,iter,weight,err_with_sign,fwd)
    %Decoding with layered structure
    global hid_lay;
    global hid_node;
    global inp_node_no;
    global out_node_no;

    inp_node_no=size(n_inp,2);
    out_node_no=1;
    
    inp=n_inp(1,:); %setting input pattern
    out=dset; %setting output value
    bias=0.01; %setting bias value
    
    if (iter~=0)
        if(err_with_sign)
            [wgt]=cal_error(inp,out,fwd,weight);
            weight=wgt;
        end
    end
    
    %---------------- Weight Initialization --------------%
    if (iter == 0)
        weight=[];
        hid_lay=1;
        for i=1:hid_lay
            hid_node(i)=2;
        end
        num=inp_node_no;
        for k=1:hid_lay
            weight{k}=initWeight(hid_node(k),num);
            num=hid_node(k);
        end
        weight{k+1}=initWeight(out_node_no,num);
    end
    %----------------------------------------------------% 

    fwd=forward(inp,bias,weight); %Forward propagation
    final=fwd{end};
     % For 2 class label
    if (final<=0.5)
        final=1;
    else
        final=2;
    end
    % For 3 class label
    %if (final<=0.35)
    %    final=1;
    %elseif((final<=0.70)&&(final>0.35))
    %    final=2;
    %else
    %    final=3;
    %end

end



