function [traindata,trainout,testdata,testout]=data_preprocessing(filename)
%Takes an excel file with the first column being names

%---------------In the form [f1,f2,f3..fn,class]----------% 
whole_data=xlsread(filename);
endeffector_coor=whole_data(:,1:end-1);
motor=whole_data(:,end);

%for 66% split
P=randperm(size(motor,1));
traindata=endeffector_coor(P(0.66:round(1*size(motor,1))),:);
trainout=motor(P(1:round(0.66*size(motor,1))),:);
testdata=endeffector_coor(P(round(0.66*size(motor,1))+1:end),:);
testout=motor(P(round(0.66*size(motor,1))+1:end),:);

% traindata=traindata(1:9,:);
% trainout=trainout(1:9,:);
% testdata=testdata(1:5,:);
% testout=testout(1:5,:);