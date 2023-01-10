classdef Granulelayer
    %Class created for defining Granule cells  
    properties %Creating class variables
        NofMo=0;            % No.Mossy fibers
        NofGoc=0;
        NofGrc=0;           % Input layer contain Granule cells,
        MF_Grc_wt=[];        %weights for MF-GrC connection
        Goc_Grc_wt=[];
        PC_input=[];
        Grc_VV=[];
        act_MF=[]           %store activated MF for the different granule cell
        Grc_time=zeros(21,100);
        MF_conn=4;
    end
    
    methods
        
        function obj=Granulelayer(In,Goc)%constructor setting vale of properties
            obj.NofGrc=ceil((In*53)/4);   %1 MF can give to 53 GrC and each GrC can get 4 MF connections  
            obj.NofMo=In;           % Number of mossyfibre
            obj.NofGoc=Goc;

            obj.MF_Grc_wt=8*ones(obj.NofMo,obj.NofGrc);%randi([1 10],obj.NofMo,obj.NofGrc);    %MF_Grc synaptic weight
            obj.Goc_Grc_wt=0.1*rand(obj.NofGoc,obj.NofGrc); 
            temp=[];
            for i=1:obj.NofGrc
                temp=cat(1,temp,randperm(obj.NofMo,obj.MF_conn));
            end
            obj.act_MF=temp; %activated MF for each Grc
        end
        
        function [Grc_VV,PC_input,Grc_time]=Grc2PCinput(obj,I_curr,Goc_curr)
            %Calculating and storing all the presynaptic spike times and
            %the corresponding weights
            for i=1:obj.NofGrc
                Inp_Grc=[];                 %for storing pre synaptic input for 1 Grc
                wt_Grc=[];                  %for storing pre synaptic weights for 1 Grc
                
                for j=1:obj.MF_conn
                    MF=obj.act_MF(i,j);
                    if(isempty(I_curr)==0)
                        Inp_Grc=cat(2,Inp_Grc,I_curr(MF,find(I_curr(MF,:))));
                        wt_Grc=cat(2,wt_Grc,obj.MF_Grc_wt(MF,i));
                        if(size(Inp_Grc,2)~=size(wt_Grc,2))
                            wt_Grc(1,end+1:size(Inp_Grc,2))=wt_Grc(1,end);
                        end
                    end

                end
                for j=1:obj.NofGoc
                    Inp_Grc=cat(2,Inp_Grc,Goc_curr);
                    wt_Grc=cat(2,wt_Grc,-(obj.Goc_Grc_wt(j,i)));
                    if(size(Inp_Grc,2)~=size(wt_Grc,2))
                        wt_Grc(1,end+1:size(Inp_Grc,2))=wt_Grc(1,end);
                    end
                end                
                [sorted_Inp_Grc,I]=sort(Inp_Grc,2);
                wt_Grc=wt_Grc(I);
                sorted_Inp_Grc;
                Inp_Grc_time{i}=sorted_Inp_Grc;     %for storing pre synaptic input for all Grc
                wt_mf_grc{i}=wt_Grc;                       %for storing pre synaptic weights for all Grc
                
                [Grc_VV(i,:),PC_input(i,:),temp]=EulerGrC(Inp_Grc_time{i},wt_mf_grc{i});   
                try
                    Grc_time(i,1:size(temp,2))=temp;
                catch 
                    temp(end:size(Grc_time,2))=0;
                    Grc_time(i,:)=temp;
                end
            end
        end
        
        function [wt]=Mf_Grc_wt_update(obj,e2)
            %Weight updation 
            wt=obj.MF_Grc_wt;
            act_MF=obj.act_MF;
            for i=1:size(act_MF,1)
                for j=1:size(act_MF,2)
                    MF=act_MF(i,j);
                    lr=0.10;
                    wt(MF,i)=wt(MF,i)+(lr.*e2.*wt(MF,i));
                end
             end
        end
        
        function sparseind=MF_Grc_121(obj,timeser)
            %To calculate the sparseness index
            MF_Grc_wt=obj.MF_Grc_wt; 
            rate=[];
            for i=1:obj.NofMo
                for j=1:obj.NofGrc
                    [Grc_VV(i,:),PC_input(i,:),temp,rate(i,j)]=EulerGrC(timeser(i,:),ones(1,length(timeser(i,:)))*MF_Grc_wt(i,j));   
                end
            end
            act_MF=obj.act_MF;
            %Sparseness index of GRc j when the 4 MF(act_MF) reach 
            for j=1:size(act_MF,1)
                for i=1:size(act_MF,2)
                    firingrate_actMF(j,i)=rate(act_MF(j,i),j);
                end

                sparseind(j)=sparsenessindx(firingrate_actMF(j,:),size(act_MF,2));
            end      
        end   
    end
end