function mf_spiketime=gauss_kernel(inp_for_sys)
    %encoding via gaussian convulution kernel

    %Normalising the features
    inp_for_sys=minmax(inp_for_sys);
    x=-360:0.1:360;
    mf_spiketime=cell(size(inp_for_sys,1),5);
    for loop_j=1:size(inp_for_sys,1)
        stor_sum_val=zeros(size(inp_for_sys,2),1800);
        tempinp=[];
        datapoints=[];

        %Adjusting the store_sum_val matrix by removing zeros from it. 
        new_storing_mat=zeros(3,5);

        for i=1:size(inp_for_sys,2)
            norm=normpdf(x,inp_for_sys(loop_j,i),10);
            norm1=conv2(norm,inp_for_sys(loop_j,i));

            %normalised 0-1
            norm1=(norm1-min(norm1))/(max(norm1)-min(norm1));

            %the maximum value and the index of it
            [M,~]=max(norm1);

            %7 neuron created with mean+/-(1,2,3)sd
            minsigma1=(inp_for_sys(loop_j,i)-(1*3));
            plussigma1=(inp_for_sys(loop_j,i)+(1*3));

            minsigma2=(inp_for_sys(loop_j,i)-(2*3));
            plussigma2=(inp_for_sys(loop_j,i)+(2*3));

            minsigma3=(inp_for_sys(loop_j,i)-(3*3));
            plussigma3=(inp_for_sys(loop_j,i)+(3*3));

            datapoints(i,:)=[minsigma3,minsigma2,minsigma1,inp_for_sys(loop_j,...
                i),plussigma1,plussigma2,plussigma3];

            % current=wt*normalised value for the AdEx model
            wt=(inp_for_sys(loop_j,i)/3)*size(datapoints,2);   

            for k=1:size(x,2)
                %for mean+|-(1|2|3)sd
                if(x(k)==ceil(minsigma1)||x(k)==ceil(minsigma2)||x(k)==...
                        ceil(plussigma1)||x(k)==ceil(plussigma2)||x(k)==...
                        ceil(minsigma3)||x(k)==ceil(plussigma3)||M==norm1(k))
                    stor_sum_val(i,k)=wt*norm1(k);             
                end
            end

        end

        for i=1:size(inp_for_sys,2)
            temp_car_val=stor_sum_val(i,:);
            %removing and replacing all 0 values
            temp_car_val(floor(temp_car_val)==0)=[];
            [~,I]=max(temp_car_val);
            if(size(datapoints,2)<=length(temp_car_val))
                tempinp=temp_car_val(I-floor(size(datapoints,2)/2):I+...
                    floor(size(datapoints,2)/2));
            else
                toadd=(I-floor(size(datapoints,2)/2):I+floor(size(datapoints,2)/2))...
                    -length(temp_car_val);
                zeromat=zeros(1,toadd);
                if(mod(toadd,2)==0)
                    tempinp=[1:zeromat/2,tempinp,(zeromat/2)+1:length(zeromat)];
                else
                    if(ceil(toadd/2)<=1)
                        tempinp=[tempinp,zeromat];
                    else
                        tempinp=[1:abs(zeromat/2),tempinp,abs(zeromat/2)+1:length(zeromat)];
                    end
                end
            end

            for j=1:size(tempinp,2)
                new_storing_mat(i,j)=tempinp(j);
            end
        end

        %------------------------------------------------------------------
        % Code to find the spiketime of 7 neurons all features
        for j=1: size(datapoints,1)
            for i=1:size(new_storing_mat,2)
                [mfspike]=EulerAdEx(new_storing_mat(j,i));
                mf_spike{i,j}=mfspike;
            end
        end

        %--------Creating spike position arrays of same length--------------%
        celength=cellfun('length',mf_spike);
        m=max(max(celength));
        for j=1: size(datapoints,1)
            for i=1:size(new_storing_mat,2)
                if (size(mf_spike{i,j},2)<m)
                    temp_zero=zeros(1,m-length(mf_spike{i,j}));
                    mf_spike{i,j}=[mf_spike{i,j},temp_zero];
                end
               temp_sp{i,1}= mf_spike{i,j};
            end
            spike_positions{j}=cell2mat(temp_sp);
        end
        %plot mf spikes
        %raster(spike_positions);
        mf_spiketime{loop_j}=spiktime2matrix(spike_positions);  
    end

end

