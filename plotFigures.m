clear
close all
load resultsNormalized
load experimentTrials
load resultsNotNormalized
load experimentTrials
numSubjects = length(experiment.fileName);
subjectName = createSubjectName('S',numSubjects);

%%

figure
subplot(2,1,1)
b = bar(100*[resultsNotNormalized.DF.powerFreqBand(1,:);resultsNotNormalized.PF1.powerFreqBand(1,:);resultsNotNormalized.PF2.powerFreqBand(1,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
legend('DP','MP','PP')
ylabel('Power')
title('Total Torque Power')
set(gca,'XTickLabel',[])
annotation('textbox','String','(A)','LineStyle','none','Position',[0.13 0.42 0.2 0.5]);
box off
subplot(2,1,2)
b = bar(100*[resultsNormalized.DF.powerFreqBand(3,:);resultsNormalized.PF1.powerFreqBand(3,:);resultsNormalized.PF2.powerFreqBand(3,:)]');
set(b(1),'FaceColor','b');
set(b(2),'FaceColor','k');
set(b(3),'FaceColor','r');
title('Tremor Power')
ylabel('Percentage of total power')
xlabel('Subject')
set(gca,'XTickLabel',subjectName)
annotation('textbox','String','(B)','LineStyle','none','Position',[0.13 0.15 0.2 0.3]);
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/totalTremorPowerPosition.pdf')
%%
diff_PF1_DF = resultsNormalized.PF1.powertorque > resultsNormalized.DF.powertorque;
diff_PF2_DF = resultsNormalized.PF2.powertorque > resultsNormalized.DF.powertorque;
diff_PF2_PF1 = resultsNormalized.PF2.powertorque > resultsNormalized.PF1.powertorque;

figure
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_PF2_DF = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_PF2_DF(i) = binomial_pval(sum(diff_PF2_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_PF2_DF,'color','r','lineWidth',1,'marker','d','markerFaceColor','r');
pValue_PF1_DF = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_PF1_DF(i) = binomial_pval(sum(diff_PF1_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_PF1_DF,'color','b','lineWidth',1,'marker','o','markerFaceColor','b');

pValue_PF2_PF1 = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_PF2_PF1(i) = binomial_pval(sum(diff_PF2_PF1(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_PF2_PF1,'--','color','k','lineWidth',2.5,'marker','s','markerFaceColor','k');
xlim([0,25])
ylim([0,1])
legend('Significance Interval','Power_{PP}, Power_{DP}',...
    'Power_{MP}, Power_{DP}'...
    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/pValuePosition.pdf')

%%

diff_MVC40_20 = resultsNormalized.PF2.MVC40.powertorque > resultsNormalized.PF2.MVC20.powertorque;
diff_MVC40_30 = resultsNormalized.PF2.MVC40.powertorque > resultsNormalized.PF2.MVC30.powertorque;
diff_MVC30_20 = resultsNormalized.PF2.MVC30.powertorque > resultsNormalized.PF2.MVC20.powertorque;

figure
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_MVC40_MVC20 = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_MVC40_MVC20(i) = binomial_pval(sum(diff_MVC40_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_MVC40_MVC20,'color','b','lineWidth',1);

pValue_MVC40_MVC30 = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_MVC40_MVC30(i) = binomial_pval(sum(diff_MVC40_30(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_MVC40_MVC30,'color','r','lineWidth',1.5);

pValue_MVC30_MVC20 = zeros(size(resultsNormalized.F));
for i = 1 : length(resultsNormalized.F)
    pValue_MVC30_MVC20(i) = binomial_pval(sum(diff_MVC30_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNormalized.F,pValue_MVC30_MVC20,'--','color','k','lineWidth',2);

xlim([0,25])
ylim([0,1])
legend('Significance Level','Power_{40%},Power_{20%}',...
    'Power_{40%},Power_{30%}'...
    ,'Power_{30%},Power_{20%}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/pValueContraction.pdf')
%%

figure
bar(100*[resultsNormalized.PF2.MVC20.powerFreqBand(3,:);resultsNormalized.PF2.MVC30.powerFreqBand(3,:);resultsNormalized.PF2.MVC40.powerFreqBand(3,:)]');
title('Tremor Power')
legend('20%','30%','40%')
ylabel('% Power')
xlabel('Subject number')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/tremorPowerContraction.pdf')

%%
figure
coherenceTremorPower_GM_TorqueDF = zeros(numSubjects,1);
coherenceTremorPower_GL_TorqueDF = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorqueDF = zeros(numSubjects,1);

coherenceTremorPower_GM_TorquePF1 = zeros(numSubjects,1);
coherenceTremorPower_GL_TorquePF1 = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorquePF1 = zeros(numSubjects,1);

coherenceTremorPower_GM_TorquePF2 = zeros(numSubjects,1);
coherenceTremorPower_GL_TorquePF2 = zeros(numSubjects,1);
coherenceTremorPower_Sol_TorquePF2 = zeros(numSubjects,1);

for i = 1 : numSubjects
    coherenceTremorPower_GM_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorqueDF(i) = resultsNotNormalized.DF.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorquePF1(i) = resultsNotNormalized.PF1.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_TorquePF2(i) = resultsNotNormalized.PF2.EMGCoherenceFreqBand{i}(3,3);
end
subplot(3,1,1)
bar(100*[coherenceTremorPower_GM_TorqueDF coherenceTremorPower_GM_TorquePF1 coherenceTremorPower_GM_TorquePF2])
legend('DP','MP','PP')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Medialis-Torque Coherence')
box off

subplot(3,1,2)
bar(100*[coherenceTremorPower_GL_TorqueDF coherenceTremorPower_GL_TorquePF1 coherenceTremorPower_GL_TorquePF2])
legend('DP','MP','PP')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Lateralis-Torque Coherence')
box off

subplot(3,1,3)
bar(100*[coherenceTremorPower_Sol_TorqueDF coherenceTremorPower_Sol_TorquePF1 coherenceTremorPower_Sol_TorquePF2])
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Soleus-Torque Coherence')
legend('DP','MP','PP')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/EMGTremorPowerPosition.pdf')
%%
diff_GM_PF1_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GM_PF2_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GM_PF2_PF1 = zeros(length(resultsNotNormalized.F),numSubjects);

diff_GL_PF1_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GL_PF2_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GL_PF2_PF1 = zeros(length(resultsNotNormalized.F),numSubjects);


diff_Sol_PF1_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_Sol_PF2_DF = zeros(length(resultsNotNormalized.F),numSubjects);
diff_Sol_PF2_PF1 = zeros(length(resultsNotNormalized.F),numSubjects);

for i = 1 : numSubjects
    diff_GM_PF1_DF(:,i) = resultsNotNormalized.PF1.EMGCoherence{i}(:,1) > resultsNotNormalized.DF.EMGCoherence{i}(:,1);
    diff_GM_PF2_DF(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,1) > resultsNotNormalized.DF.EMGCoherence{i}(:,1);
    diff_GM_PF2_PF1(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,1) > resultsNotNormalized.PF1.EMGCoherence{i}(:,1);
    
    diff_GL_PF1_DF(:,i) = resultsNotNormalized.PF1.EMGCoherence{i}(:,2) > resultsNotNormalized.DF.EMGCoherence{i}(:,2);
    diff_GL_PF2_DF(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,2) > resultsNotNormalized.DF.EMGCoherence{i}(:,2);
    diff_GL_PF2_PF1(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,2) > resultsNotNormalized.PF1.EMGCoherence{i}(:,2);
    
    diff_Sol_PF1_DF(:,i) = resultsNotNormalized.PF1.EMGCoherence{i}(:,3) > resultsNotNormalized.DF.EMGCoherence{i}(:,3);
    diff_Sol_PF2_DF(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,3) > resultsNotNormalized.DF.EMGCoherence{i}(:,3);
    diff_Sol_PF2_PF1(:,i) = resultsNotNormalized.PF2.EMGCoherence{i}(:,3) > resultsNotNormalized.PF1.EMGCoherence{i}(:,3);
end
figure
subplot(3,1,1)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_PF2_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_DF(i) = binomial_pval(sum(diff_GM_PF2_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_DF,'color','b','lineWidth',1);
pValue_PF1_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF1_DF(i) = binomial_pval(sum(diff_GM_PF1_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF1_DF,'color','r','lineWidth',1.5);

pValue_PF2_PF1 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_PF1(i) = binomial_pval(sum(diff_GM_PF2_PF1(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_PF1,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
legend('Significance Interval','Power_{PP}, Power_{DP}',...
    'Power_{MP}, Power_{DP}'...
    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Medialis Gastrocnemius-Torque Coherence')
box off

subplot(3,1,2)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_PF2_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_DF(i) = binomial_pval(sum(diff_GL_PF2_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_DF,'color','b','lineWidth',1);
pValue_PF1_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF1_DF(i) = binomial_pval(sum(diff_GL_PF1_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF1_DF,'color','r','lineWidth',1.5);

pValue_PF2_PF1 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_PF1(i) = binomial_pval(sum(diff_GL_PF2_PF1(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_PF1,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
%legend('Significance Interval','Power_{PP}, Power_{DP}',...
%    'Power_{MP}, Power_{DP}'...
%    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Lateralis Gastrocnemius-Torque Coherence')
box off

subplot(3,1,3)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_PF2_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_DF(i) = binomial_pval(sum(diff_Sol_PF2_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_DF,'color','b','lineWidth',1);
pValue_PF1_DF = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF1_DF(i) = binomial_pval(sum(diff_Sol_PF1_DF(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF1_DF,'color','r','lineWidth',1.5);

pValue_PF2_PF1 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_PF2_PF1(i) = binomial_pval(sum(diff_Sol_PF2_PF1(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_PF2_PF1,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
%legend('Significance Interval','Power_{PP}, Power_{DP}',...
%    'Power_{MP}, Power_{DP}'...
%    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Soleus-Torque Coherence')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and results/pValueEMGPosition.pdf')
%%
figure
bar(100*[resultsNotNormalized.PF2.MVC20.powerFreqBand(1,:);resultsNotNormalized.PF2.MVC30.powerFreqBand(1,:);resultsNotNormalized.PF2.MVC40.powerFreqBand(1,:)]');
legend('20%','30%','40%')
ylabel('Power')
xlabel('Subject number')
title('Total Power')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and results/totalPowerContraction.pdf')

%%
figure
coherenceTremorPower_GM_Torque_MVC20 = zeros(numSubjects,1);
coherenceTremorPower_GL_Torque_MVC20 = zeros(numSubjects,1);
coherenceTremorPower_Sol_Torque_MVC20 = zeros(numSubjects,1);

coherenceTremorPower_GM_Torque_MVC30 = zeros(numSubjects,1);
coherenceTremorPower_GL_Torque_MVC30 = zeros(numSubjects,1);
coherenceTremorPower_Sol_Torque_MVC30 = zeros(numSubjects,1);

coherenceTremorPower_GM_Torque_MVC40 = zeros(numSubjects,1);
coherenceTremorPower_GL_Torque_MVC40 = zeros(numSubjects,1);
coherenceTremorPower_Sol_Torque_MVC40 = zeros(numSubjects,1);

for i = 1 : numSubjects
    coherenceTremorPower_GM_Torque_MVC20(i) = resultsNotNormalized.PF2.MVC20.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_Torque_MVC20(i) = resultsNotNormalized.PF2.MVC20.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_Torque_MVC20(i) = resultsNotNormalized.PF2.MVC20.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_Torque_MVC30(i) = resultsNotNormalized.PF2.MVC30.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_Torque_MVC30(i) = resultsNotNormalized.PF2.MVC30.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_Torque_MVC30(i) = resultsNotNormalized.PF2.MVC30.EMGCoherenceFreqBand{i}(3,3);
    
    coherenceTremorPower_GM_Torque_MVC40(i) = resultsNotNormalized.PF2.MVC40.EMGCoherenceFreqBand{i}(3,1);
    coherenceTremorPower_GL_Torque_MVC40(i) = resultsNotNormalized.PF2.MVC40.EMGCoherenceFreqBand{i}(3,2);
    coherenceTremorPower_Sol_Torque_MVC40(i) = resultsNotNormalized.PF2.MVC40.EMGCoherenceFreqBand{i}(3,3);
end
subplot(3,1,1)
bar(100*[coherenceTremorPower_GM_Torque_MVC20 coherenceTremorPower_GM_Torque_MVC30 coherenceTremorPower_GM_Torque_MVC40])
legend('20%','30%','40%')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Medialis-Torque Coherence')
box off

subplot(3,1,2)
bar(100*[coherenceTremorPower_GL_Torque_MVC20 coherenceTremorPower_GL_Torque_MVC30 coherenceTremorPower_GL_Torque_MVC40])
legend('20%','30%','40%')
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Gastrocnemius Lateralis-Torque Coherence')
box off

subplot(3,1,3)
bar(100*[coherenceTremorPower_Sol_Torque_MVC20 coherenceTremorPower_Sol_Torque_MVC30 coherenceTremorPower_Sol_Torque_MVC40])
ylabel('%Power')
xlabel('Subject number')
title('Tremor Power Soleus-Torque Coherence')
legend('20%','30%','40%')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and results/EMGTremorPowerContraction.pdf')
%%

diff_GM_MVC40_20 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GM_MVC40_30 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GM_MVC30_20 = zeros(length(resultsNotNormalized.F),numSubjects);

diff_GL_MVC40_20 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GL_MVC40_30 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_GL_MVC30_20 = zeros(length(resultsNotNormalized.F),numSubjects);


diff_Sol_MVC40_20 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_Sol_MVC40_30 = zeros(length(resultsNotNormalized.F),numSubjects);
diff_Sol_MVC30_20 = zeros(length(resultsNotNormalized.F),numSubjects);

for i = 1 : numSubjects
    diff_GM_MVC40_20(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,1) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,1);
    diff_GM_MVC40_30(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,1) > resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,1);
    diff_GM_MVC30_20(:,i) = resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,1) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,1);
    
    diff_GL_MVC40_20(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,2) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,2);
    diff_GL_MVC40_30(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,2) > resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,2);
    diff_GL_MVC30_20(:,i) = resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,2) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,2);
    
    diff_Sol_MVC40_20(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,3) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,3);
    diff_Sol_MVC40_30(:,i) = resultsNotNormalized.PF2.MVC40.EMGCoherence{i}(:,3) > resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,3);
    diff_Sol_MVC30_20(:,i) = resultsNotNormalized.PF2.MVC30.EMGCoherence{i}(:,3) > resultsNotNormalized.PF2.MVC20.EMGCoherence{i}(:,3);
end
figure
subplot(3,1,1)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_40_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_20(i) = binomial_pval(sum(diff_GM_MVC40_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_20,'color','b','lineWidth',1);
pValue_40_30 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_30(i) = binomial_pval(sum(diff_GM_MVC40_30(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_30,'color','r','lineWidth',1.5);

pValue_30_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_30_20(i) = binomial_pval(sum(diff_GM_MVC30_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_30_20,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
legend('Significance Level','Power_{40%},Power_{20%}',...
    'Power_{40%},Power_{30%}'...
    ,'Power_{30%},Power_{20%}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Medialis Gastrocnemius-Torque Coherence')
box off

subplot(3,1,2)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_40_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_20(i) = binomial_pval(sum(diff_GL_MVC40_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_20,'color','b','lineWidth',1);
pValue_40_30 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_30(i) = binomial_pval(sum(diff_GL_MVC40_30(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_30,'color','r','lineWidth',1.5);

pValue_30_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_30_20(i) = binomial_pval(sum(diff_GL_MVC30_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_30_20,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
%legend('Significance Interval','Power_{PP}, Power_{DP}',...
%    'Power_{MP}, Power_{DP}'...
%    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Lateralis Gastrocnemius-Torque Coherence')
box off

subplot(3,1,3)
hold on
fill([0,0,25,25],[0,0.05,0.05,0],[225,225,225]/255)
pValue_40_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_20(i) = binomial_pval(sum(diff_Sol_MVC40_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_20,'color','b','lineWidth',1);
pValue_40_30 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_40_30(i) = binomial_pval(sum(diff_Sol_MVC40_30(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_40_30,'color','r','lineWidth',1.5);

pValue_30_20 = zeros(size(resultsNotNormalized.F));
for i = 1 : length(resultsNotNormalized.F)
    pValue_30_20(i) = binomial_pval(sum(diff_Sol_MVC30_20(i,:))/numSubjects,numSubjects,0.5,'both');
end
plot(resultsNotNormalized.F,pValue_30_20,'--','color','k','lineWidth',2);
xlim([0,25])
ylim([0,1])
%legend('Significance Interval','Power_{PP}, Power_{DP}',...
%    'Power_{MP}, Power_{DP}'...
%    ,'Power_{PP}, Power_{MP}')
xlabel('Frequency (Hz)')
ylabel('P-Value')
title('Soleus-Torque Coherence')
box off
saveas(gcf,'/Users/Kian/Documents/publication/tremor/Ankle/Tremor/Analysis and Results/pValueEMGContraction.pdf')
