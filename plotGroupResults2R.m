clear
close all
clear
load dataGroupResults2R

figure
subplot(3,1,1)
b = bar(100*[totalPowerNotNormalizedDF(1,:);totalPowerNotNormalizedPF1(1,:);totalPowerNotNormalizedPF2(1,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
legend('DP','MP','PP')
ylabel('Power')
title('Total Torque Power')
set(gca,'XTickLabel',[])
annotation('textbox','String','(A)','LineStyle','none','Position',[0.13 0.42 0.2 0.5]);
box off
subplot(3,1,2)
b = bar(100*[totalPowerNormalizedDF(3,:);totalPowerNormalizedPF1(3,:);totalPowerNormalizedPF2(3,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
title('Torque Power in Tremor Range')
ylabel('Precentage of total power')
set(gca,'XTickLabel',[])
annotation('textbox','String','(B)','LineStyle','none','Position',[0.13 0.32 0.2 0.3]);
box off
subplot(3,1,3)

b = bar(100*[coherenceTremorPower_GM_TorqueDF coherenceTremorPower_GM_TorquePF1 coherenceTremorPower_GM_TorquePF2]);
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
ylabel('Precentage of total area')
set(gca,'XTickLabel',subjectName)
xlabel('Subject number')
title('EMG-Torque Coherence Area in Tremor Range')
annotation('textbox','String','(C)','LineStyle','none','Position',[0.13 0.02 0.2 0.3]);
box off
