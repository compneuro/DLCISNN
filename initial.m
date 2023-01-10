filename='tennis.xlsx';
wholedata=xlsread(filename)
traindata=wholedata(:,1:end-1)
trainout=wholedata(:,end);
cnt_MF=input('Enter the number of MFneurons to be created for each feature: ');
I=gauss_kernel_m(traindata,cnt_MF)