function Vt = Voltage( V,w,I)
    C=900;
    gl=10;
    el=-70;
    delT=2;
    Vt=-50;
    Vt=((gl*(el-V)+gl*delT*exp((V-Vt)/delT)+I-w)/C);

end

