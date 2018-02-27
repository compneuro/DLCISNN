function [wgt]=cal_error(inp,out,fwd,wgt)

    global hid_node;
    global hid_lay;

    inpt_len=length(inp);
    out_len=length(out);

    %-------- FINDING ERROR SIGNAL AND UPDATE WEIGHT OF OUTPUT LAYER -------
    % Error Calculation
    cal_out=fwd{end};
    errSgnl_out_node=(out-cal_out)*cal_out*(1-cal_out);
    check=length(fwd)-1;

    % Weight Updation
    learng_rate=0.01;
    err_Out=learng_rate*errSgnl_out_node;
    
    for i =1:hid_node(end)
        wgt{end}(1,i)=wgt{end}(1,i)-(err_Out*fwd{check}(1,i));
    end

    %-------- FINDING ERROR SIGNAL AND UPDATE WEIGHT OF HIDDEN LAYER -------
    errSgnl{hid_lay+1}=errSgnl_out_node;
    
    for k=hid_lay:-1:1
        if (k==hid_lay)
            lay_node=out_len;
        else
            lay=k+1;
            lay_node=hid_node(lay);
        end
        for i=1:hid_node(k)
            delta_error=0;
            cal_out=fwd{check}(1,i);

            for j=1:lay_node
                delta_error=delta_error + errSgnl{k+1}(j,1)*wgt{k+1}(j,i);
            end
            
            errSgnl{k}(i,1)=delta_error*cal_out*(1-cal_out)*learng_rate;   %finding error of hidden layer
            if (hid_lay==1 || k==1)                                        %go inside the loop only if there is one hidden layer or if value of k=1
                m_node=inpt_len;
                for l=1:m_node
                    wgt{k}(i,l)=wgt{k}(i,l)-errSgnl{k}(i,1)*inp(l);   %Update weight of hidden layer
                end
            else
                m=k-1;
                m_node=hid_node(m);
                for l=1:m_node
                    wgt{k}(i,l)=wgt{k}(i,l)-errSgnl{k}(i,1)*fwd{check-1}(1,l);  %Update weight of hidden layer
                end
            end
        end
        check=check-1;
    end

end

