function [Grc_ob,PC_ob,PC_time,Goc_ob]=create_network(timeser,PC_count,f,e1,Goc_ob,Grc_ob,PC_ob)

    global tot_wt;
    global Grc_sparseind_b4
    global Grc_sparseind_after
    global it
    
    %-----------Initial network creation------------%
    if(f==0)
        MF_count=size(timeser,1);
        
        Goc_ob=Golgicells(MF_count,1);
        [Goc_VV,Grc_input,Goc_time]=Goc_ob.Goc2Grcinput(timeser);
        Goc_ob.Grc_input=Grc_input;
        Goc_ob.Goc_VV=Goc_VV;
        Goc_ob.Goc_time=Goc_time;
        Grc_ob=Granulelayer(MF_count,size(Goc_time,1));
        Grc_count=Grc_ob.NofGrc;
        %Grc_sparseind_b4=Grc_ob.MF_Grc_121(timeser);
        PC_ob=Purkinjelayer(Grc_count,PC_count);
    end
    
    %--------------Weight updation at MF-Grc-----------%
    if(f~=0)

        mf_grc_wt=Grc_ob.Mf_Grc_wt_update(e1);
        Grc_ob.MF_Grc_wt=mf_grc_wt;
        Goc_time=Goc_ob.Goc_time;
        if(it==50)
             Grc_sparseind_after=Grc_ob.MF_Grc_121(timeser);
        end
    end
    %--------------------------------------------------%
    
    Goc_time=Goc_ob.Goc_time;
    [Grc_VV,PC_input,Grc_time]=Grc_ob.Grc2PCinput(timeser,Goc_time);
    Grc_ob.PC_input=PC_input;
    Grc_ob.Grc_VV=Grc_VV;
    Grc_ob.Grc_time=Grc_time;

    %--------------Weight updation at Grc-PC-----------%
    if(f~=0)
        pf_pc_wt=PC_ob.Pf_PC_wt_update(e1);
        PC_ob.Grc_PC_wt=pf_pc_wt;
    end
    %--------------------------------------------------%

    [PC_output,PC_time,PC_VV]=PC_ob.PCAdex(PC_input);
    PC_ob.PC_output=PC_output;
    PC_ob.PC_time=PC_time;
    PC_ob.PC_VV=PC_VV;
    tot_wt{1}=Grc_ob.MF_Grc_wt;
    tot_wt{2}=PC_ob.Grc_PC_wt;
end

