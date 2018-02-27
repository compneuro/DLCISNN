function Vt = VoltagePC(V,w,I)
%implement the membrane potential equation of the AdEx
%-I is for synatptic current
%+I is for injected current
    C=100; 
    gl=10;
    el=-65;
    delT=2;
    Vt=-50;
    Vt=((gl*(el-V)+gl*delT*exp((V-Vt)/delT)-I-w)/C);

end

