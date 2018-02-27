function wt= AdCurrentPC(V,w )
%Comput the adaptation factor equation for AdEx

    el=-65;
    a=-13;
    tw=1;
    wt=((a*(V-el)-w)/tw);

end
