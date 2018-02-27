function Vt = VoltageGoC(V,w,I)
%-I is for synatptic current
%+I is for injected current
    C=500;
    gl=13.1;
    el=-58;
    delT=7;
    Vx=-54;
    Vt=((gl*(el-V)+gl*delT*exp((V-Vx)/delT)-I-w)/C);

end

