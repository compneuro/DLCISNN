 function [VV,PC_times,temp,n]=EulerGrC(times,wt)
    dt=1; % time interval 1ms
    time=300;
    x=0:dt:time;
    V=[];
    w=[];
    VV=[];
    j=1;
    n=0;
    Vr=-64;
    flg=0;
    b=250;
    el=-70;
    i=1;gc=0;k=1;
    V(i)=-70;
    w(i)=V-el;
    PC_times=[];temp=[];cnt=1;
    %find(times)
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
        V(i+1)=V(i)+dt*(feval('VoltageGrC',V(i),w(i),I));
        w(i+1)=w(i)+dt*(feval('AdCurrentGrC',V(i),w(i)));
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
        
        if (V(i)>-40)&&(flg==0)
            flg=1;
            PC_times(1,j)=1; % set activity=1 at the time of spike
            n=n+1;
            temp(1,cnt)=t;
            cnt=cnt+1;

        else
            PC_times(1,j)=0;
        end
        j=j+1;

    end
end