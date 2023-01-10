classdef Golgicells
    %Class created for defining Golgi cells  
    properties %Creating class variables
        NofMo=0;            % No.Mossy fibers
        NofGoc=0;           % No.Golgi cell
        MF_Goc_wt=[];        %weights for MF-GoC connection
        Grc_input=[];
        Goc_VV=[];
        Goc_time=zeros(1,100);
    end
    methods
        
        function obj=Golgicells(In,Out)%constructor setting vale of properties
            obj.NofGoc=Out;   % #GoC 
            obj.NofMo=In;     % Number of mossyfibre
            obj.MF_Goc_wt=rand(obj.NofMo,obj.NofGoc);    %MF_Goc synapse eg 21*279 wtmfgrc;randi(10,1,1)*
        end
        
        function [Goc_VV,Grc_input,Goc_time]=Goc2Grcinput(obj,I_curr)
            %Defining the spike patterns for Grc        
            %Calculating and storing all the presynaptic spike times and
            %the corresponding weights
            for i=1:obj.NofGoc
                for j=1:obj.NofMo
                    Inp_Goc_time=sort(reshape(I_curr,1,[]));
                    Inp_Goc_time=Inp_Goc_time(find(Inp_Goc_time));
                    wt=zeros(1,length(Inp_Goc_time));
                    for k=1:length(Inp_Goc_time)
                        [r,~]=find(I_curr==Inp_Goc_time(k));
                        if(length(r)==1)
                            wt(k)=obj.MF_Goc_wt(r,i);
                        else
                            wt(k:k+length(r)-1)=obj.MF_Goc_wt(r,i);
                            k=k+length(r)-1;
                        end
                    end
                end
                [Goc_VV(i,:),Grc_input(i,:),temp]=EulerGoC(Inp_Goc_time,wt);   
                try
                    Goc_time(i,1:size(temp,2))=temp;
                catch 
                    temp(end:size(Goc_time,2))=0;
                    Goc_time(i,:)=temp;
                end 
            end
        
        end
        
    end
end