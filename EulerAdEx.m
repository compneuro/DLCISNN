function [mfspike]= EulerAdEx(I)
    % To generate mossyfiber patterns 
    dt=1;
    x=0:dt:300;
    
    V=[];
    w=[];
    VV=[];
    spiketime=zeros(1,size(x,2));
    mfspike=[];
    
    Vr=-58;
    b=265;
    el=-70;
    i=1;
    V(i)=-60;
    w(i)=V-el;
    sp_cnt=1;

    for t=x
        V(i+1)=V(i)+dt*(feval('Voltage',V(i),w(i),I));
        w(i+1)=w(i)+dt*(feval('AdCurrent',V(i),w(i)));

        if V(i+1) > 0
            VV(end+1)=0;
            V(i+1)=Vr;
            w(i+1)=w(i+1)+b;
            spiketime(i+1)=1;
            mfspike(sp_cnt)=t;
            %spikecount would be sp_cnt-1
            sp_cnt=sp_cnt+1;
        else
            VV(end+1)=V(i+1);

        end
        i=i+1;
    end
end
