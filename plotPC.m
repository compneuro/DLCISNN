function plotPC(PC_ob,c)
PC_VV=PC_ob.PC_VV;
% figure(8)
% for i=1:size(PC_VV,1)
%     subplot(size(PC_VV,1),1,i)
%     plot(PC_VV(i,:),c)
%     xlim([0 1000])
%     ylim([-65 0])
% end
% hold on
figure(5)
y=1:size(PC_ob.Grc_PC_wt,2);
for i=1:size(PC_ob.Grc_PC_wt,1)
    z=PC_ob.Grc_PC_wt(i,:);
    x=i*ones(1,size(PC_ob.Grc_PC_wt,2));
    scatter3(x,y,z,c)
    hold on
end
hold on

figure(8)
% for i=1:size(PC_VV,1)
    size(PC_VV)
    plot(PC_VV(1,:),c)
     xlim([0 300])
     ylim([-70 30])
     hold on
% end
PC_time=PC_ob.PC_time;
figure(9)
for i=1:size(PC_time,1)
    for j=1:length(find(PC_time(i,:)))
        plot([PC_time(i,j) PC_time(i,j)],[i-0.4 i+0.4],c)
        hold on
    end
    hold on
end
hold on
figure(10)
plot(mean(PC_VV,1),c)
xlim([0 300])
% ylim([-65 0])
hold on