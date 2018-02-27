 function [VV]=GoC()
    dt=1; % time interval 1ms
    time=1000;x=0:dt:time;
    V=[];w=[];VV=[];
    j=1;
    n=0;
    Vr=-64;
    flg=0;
    b=250;
    el=-70;
    I=350;
    i=1;
    %gc=4.25; %conductane is set to get 1 spike  
    %gc=0;
    %wt=25;
    k=1;
    V(i)=-70;
    w(i)=V-el;
    PC_times=[];
    temp=[];cnt=1;
    for t=x

        %euler method for ODE
        V(i+1)=V(i)+dt*(feval('VoltageGoC',t,V(i),w(i),I));
        w(i+1)=w(i)+dt*(feval('AdCurrentGoC',t,V(i),w(i)));
%        gc=gc+dt*(feval('synaptic_conductance',gc));
        if V(i+1) > 30
            VV(end+1)=30;
            V(i+1)=Vr;
            w(i+1)=w(i+1)+b;
%                    gc=4.25;
            flg=0;
        else
            VV(end+1)=V(i+1);
        end
        i=i+1;
         %checking threshold crossing


    end
    VV;
    %temp;
    plot(x,VV)
end