classdef Purkinjelayer 
    %New class for neural network
    properties %Creating class variables
        NofPC=0;            % No.Purkinje cell output
        NofGrc=0;           % Input layer contain Granule cells,
        Grc_PC_wt=[];        %weights for GrC-PC connection
        PC_output=[];
        PC_time=[];
        PC_VV=[];
        act_Grc=[];
        Grc_conn=48;
    end
    methods
        
        function obj=Purkinjelayer(In,Out)%constructor setting vale of properties
            obj.NofGrc=In;
            obj.NofPC=Out;
            obj.Grc_PC_wt=ones(In,Out);%rand(In,Out);%wtgrcpc;
            temp=[];
            for i=1:obj.NofPC
                temp=cat(1,temp,randperm(obj.NofGrc,obj.Grc_conn));
            end
            obj.act_Grc=temp; %activated Grc for each PC
        end
        
        function [PC_output,PC_time,PC_VV]=PCAdex(obj,I_curr)
            PC_time=[];
            PC_VV=[];
            act_grc=obj.act_Grc;
            wt=obj.Grc_PC_wt;
            PC_output=[];
            for i=1:obj.NofPC
                summedup=[];
                for j=1: obj.Grc_conn
                    Grc=act_grc(i,j);
                    temp=I_curr(Grc,:).*wt(Grc,i);
                    summedup=cat(1,summedup,temp);
                end
                PC_output=cat(1,PC_output,sum(summedup,1));
                [VV,temp]=EulerPC(PC_output(i,:));
                PC_time(i,1:size(temp,2))=temp;
                PC_VV(i,:)=VV;
            end          
        end
        
        function [wt]=Pf_PC_wt_update(obj,e1)
            % Weight updation
            wt=obj.Grc_PC_wt;
            actGrc=obj.act_Grc;
            for i=1:size(e1,2)
                lr=0.35;
                for j=1:size(actGrc,2)
                    Grc=actGrc(i,j);
                    wt(Grc,i)=wt(Grc,i)-(lr.*e1.*wt(Grc,i));
                end
            end
        end
    end
end

            
            