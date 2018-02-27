function plotGoc(Goc_ob,c)
%global Grc_ob
Goc_VV=Goc_ob.Goc_VV;
Goc_time=Goc_ob.Goc_time;

% figure(1)
% y=[1:size(Goc_ob.MF_Goc_wt,2)];
% for i=1:size(Goc_ob.MF_Goc_wt,1)
%     z=Goc_ob.MF_Goc_wt(i,:);
%     x=i*ones(1,size(Goc_ob.MF_Goc_wt,2));
%     scatter3(x,y,z,c)
%     hold on
% end

% figure(2)    
% for i=1:size(Goc_time,1)
%     for j=1:length(find(Goc_time(i,:)))
%         plot([Goc_time(i,j) Goc_time(i,j)],[i-0.4 i+0.4],c)
%         hold on
%     end
%     hold on
% end
% hold on
figure(3)
plot(Goc_VV,c)
xlim([0 300])
ylim([-80 0])
hold on
