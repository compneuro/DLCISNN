function plotGrc(Grc_ob,c)
%global Grc_ob
Grc_VV=Grc_ob.Grc_VV;
Grc_time=Grc_ob.Grc_time;
% figure(5)
% for i=1:size(Grc_VV,1)
%     subplot(size(spike_positions,2),size(spike_positions{1},1),i)
%     plot(Grc_VV(i,:),c)
%     xlim([0 1000])
%     ylim([-65 0])
% end
% hold on
% figure()
% for i=1:size(Grc_VV,1)
%      plot(0:1:1000,Grc_VV(i,:),c)
%      xlim([0 1000])
%      ylim([-70 30])
% end
figure(4)
y=1:size(Grc_ob.MF_Grc_wt,2);
for i=1:size(Grc_ob.MF_Grc_wt,1)
    z=Grc_ob.MF_Grc_wt(i,:);
    x=i*ones(1,size(Grc_ob.MF_Grc_wt,2));
    scatter3(x,y,z,c)
    hold on
end

figure(6)    
for i=1:size(Grc_time,1)
    for j=1:length(find(Grc_time(i,:)))
        plot([Grc_time(i,j) Grc_time(i,j)],[i-0.4 i+0.4],c)
        hold on
    end
    hold on
end
hold on
figure(7)
plot(mean(Grc_VV,1),c)
xlim([0 300])
%ylim([-65 0])
hold on
%size(Grc_VV)