function Vt = VoltageGrC(V,w,I)
%-I is for synatptic current
%+I is for injected current
    C=150;
    gl=10;
    el=-70;
    delT=4;
    Vx=-50;
    Vt=((gl*(el-V)+gl*delT*exp((V-Vx)/delT)-I-w)/C);

end

