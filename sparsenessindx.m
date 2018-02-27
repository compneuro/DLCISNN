function S=sparsenessindx(I_firingrate,noofstimuli)
A=0;
B=0;
for i=1:noofstimuli
    I_firingrate(i);
    A=A+(I_firingrate(i)/noofstimuli);
    B=B+((I_firingrate(i)^2)/noofstimuli);
end
A;
B;
C=A^2/B;
S=(1-C)/(1-(1/noofstimuli));