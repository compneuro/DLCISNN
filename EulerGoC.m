 function [VV,Goc_times,temp]=EulerGoC(times,wt)
    
    V=[];
    w=[];
    VV=[];
    Goc_times=[];
    temp=[];
    
    dt=1;time=300;
    x=0:dt:time;
    j=1;flg=0;i=1;gc=0;k=1;cnt=1;
    
    Vr=-50;
    b=1033;
    el=-58;
    V(i)=-58;
    w(i)=V-el;
   
    for t=x
        if(~isempty(times))
            while(t==round(times(k)))
                gc=gc+wt(k);
                if(k<length(times))%checking the array limit exceding condition
                    k=k+1;
                elseif(k==length(times))
                    gc=gc-wt(k);
                    break
                end
            end
        end
        I=gc*(V(i)-0);

        %euler method for ODE
        V(i+1)=V(i)+dt*(feval('VoltageGoC',V(i),w(i),I));
        w(i+1)=w(i)+dt*(feval('AdCurrentGoC',V(i),w(i)));
        gc=gc+dt*(feval('synaptic_conductance',gc));
        if V(i+1) > 30
            VV(end+1)=30;
            V(i+1)=Vr;
            w(i+1)=w(i+1)+b;
            flg=0;
        else
            VV(end+1)=V(i+1);
        end
        i=i+1;
        %checking threshold crossing

        if (V(i)>-40)&&(flg==0)
            flg=1;
            Goc_times(1,j)=1; % set activity=1 at the time of spike
            temp(1,cnt)=t;
            cnt=cnt+1;

        else
            Goc_times(1,j)=0;
        end
        j=j+1;

    end
end