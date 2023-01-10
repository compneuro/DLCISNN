clear all; 
clear classes
clc

global tot_wt;
global motor_err;
global wt_4_memoryconsolidated;


tic
%------------------Extracting data from excel file---------------------
filename='tennis.xlsx';
[traindata,trainout,testdata,testout]=data_preprocessing(filename);
%----------------------------------------------------------------------

disp('----------------------Encoding------------------')
%finding the mossy fibre spike positions(a cell array)with 7 neurons
%spike positions for each feature 
cnt_MF=input('Enter the number of MFneurons to be created for each feature: ');
mf_spiketime=gauss_kernel([traindata;testdata],cnt_MF);
mf_test=mf_spiketime((size(traindata,1)+1):end);       
%[max_size, max_index] = max(cellfun('size', mf_spiketime, 1));

% load('MFspike.mat')
% load('endeff.mat')
% load('motor.mat')
% load('testdata.mat')
% load('testout.mat')

disp('----------------Creating cerebellar network-------------------') 

[Grc_ob,PC_ob,PC_time,Goc_ob]=create_network(mf_spiketime{1},size(trainout,2),0,0,0);
grc_int=Grc_ob;
pc_init=PC_ob;
%Rate coding PC output into bins
temp=spik_cnt_calc(PC_time(1,:));

disp('----------------Decoding-------------------')
[pre_mtr_angle{1,1}(1),wt,fwd{1}{1}]=decoding(temp,trainout(1,1),0,0,0);

disp('----------------Error and weight consolidation-------------------')
if (trainout(1,1)-pre_mtr_angle{1,1}(1))
    err_with_sign(1,1)=1;
else
    err_with_sign(1,1)=0;
end

motor_err{1}(1,1)=err_with_sign(1,1);
tot_wt{3}{1,1}=wt;
%Weight in the network for each input pattern is stored
wt_4_memoryconsolidated{1}=tot_wt;


disp('------------------------Training phase------------------------')
[Grc_ob,PC_ob,predicted_trainout,err_with_sign]=training(mf_spiketime,trainout,1,Goc_ob,Grc_ob,PC_ob,fwd);

toc

tic
disp('------------------------Testing phase------------------------')
[pred_testout,testerr]=testpart(mf_test,testout,testdata,cnt_MF,Goc_ob,Grc_ob,PC_ob);
toc

disp('------------------------Error percent------------------------')
tot=sum(abs(motor_err{end}));
trainerrpercent=(tot/size(trainout,1))*100;

tot1=sum(abs(testerr));
testerrpercent=tot1/size(testout,1)*100
         
