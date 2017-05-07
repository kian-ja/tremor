nSubjects = length(resultsNormalizedHPF.PF2.EMG_TA_RMS);
EMG_TA = zeros(7,3);
EMG_GSMed = zeros(7,3);
EMG_GSLat = zeros(7,3);
EMG_Sol = zeros(7,3);
for i = 1 : nSubjects
    EMG_TA(i,1) = resultsNormalizedHPF.DF.EMG_TA_RMS{i};
    EMG_TA(i,2) = resultsNormalizedHPF.PF1.EMG_TA_RMS{i};
    EMG_TA(i,3) = resultsNormalizedHPF.PF2.EMG_TA_RMS{i};
    
    EMG_GSMed(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i}(1);
    EMG_GSMed(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i}(1);
    EMG_GSMed(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i}(1);
    
    EMG_GSLat(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i}(2);
    EMG_GSLat(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i}(2);
    EMG_GSLat(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i}(2);
    
    EMG_Sol(i,1) = resultsNormalizedHPF.DF.EMG_RMS{i}(3);
    EMG_Sol(i,2) = resultsNormalizedHPF.PF1.EMG_RMS{i}(3);
    EMG_Sol(i,3) = resultsNormalizedHPF.PF2.EMG_RMS{i}(3);
    
end
%%
[~,pPF_MID] = ttest(EMG_GSMed(:,1),EMG_GSMed(:,2));
[~,pPF_DF] = ttest(EMG_GSMed(:,1),EMG_GSMed(:,3));
[~,pMID_DF] = ttest(EMG_GSMed(:,3),EMG_GSMed(:,2));
disp(['EMG-GS Medial p value PF-MID is: ', num2str(pPF_MID)])
disp(['EMG-GS Medial p value PF-DF is: ', num2str(pPF_DF)])
disp(['EMG-GS Medial p value MID-DF is: ', num2str(pMID_DF)])

[~,pPF_MID] = ttest(EMG_GSLat(:,1),EMG_GSLat(:,2));
[~,pPF_DF] = ttest(EMG_GSLat(:,1),EMG_GSLat(:,3));
[~,pMID_DF] = ttest(EMG_GSLat(:,3),EMG_GSLat(:,2));
disp(['EMG-GS Lateral p value PF-MID is: ', num2str(pPF_MID)])
disp(['EMG-GS Lateral p value PF-DF is: ', num2str(pPF_DF)])
disp(['EMG-GS Lateral p value MID-DF is: ', num2str(pMID_DF)])

[~,pPF_MID] = ttest(EMG_Sol(:,1),EMG_GSLat(:,2));
[~,pPF_DF] = ttest(EMG_GSLat(:,1),EMG_GSLat(:,3));
[~,pMID_DF] = ttest(EMG_GSLat(:,3),EMG_GSLat(:,2));
disp(['EMG-GS Soleus p value PF-MID is: ', num2str(pPF_MID)])
disp(['EMG-GS Soleus p value PF-DF is: ', num2str(pPF_DF)])
disp(['EMG-GS Soleus p value MID-DF is: ', num2str(pMID_DF)])
%%
pDF_MID = pValueSign2Sided(EMG_TA(:,1)',EMG_TA(:,2)');
pDF_PF = pValueSign2Sided(EMG_TA(:,1)',EMG_TA(:,3)');
pPF_MID = pValueSign2Sided(EMG_TA(:,3)',EMG_TA(:,2)');
disp(['EMG-TA p value DF-MID is: ', num2str(pDF_MID)])
disp(['EMG-TA p value DF-PF is: ', num2str(pDF_PF)])
disp(['EMG-TA p value PF-MID is: ', num2str(pPF_MID)])


[~,pPF_MID] = ttest(EMG_TA(:,1),EMG_TA(:,2));
[~,pPF_DF] = ttest(EMG_TA(:,1),EMG_TA(:,3));
[~,pMID_DF] = ttest(EMG_TA(:,3),EMG_TA(:,2));
disp(['EMG-TA p value PF-MID is: ', num2str(pPF_MID)])
disp(['EMG-TA Soleus p value PF-DF is: ', num2str(pPF_DF)])
disp(['EMG-TA Soleus p value MID-DF is: ', num2str(pMID_DF)])
%%
EMGStack = [EMG_GSMed(:,1);EMG_GSMed(:,2);EMG_GSMed(:,3);EMG_GSLat(:,1);...
    EMG_GSLat(:,2);EMG_GSLat(:,3);EMG_Sol(:,1);EMG_Sol(:,2);EMG_Sol(:,3)];
EMGType = [ones(7,1);ones(7,1)*2;ones(7,1)*3;ones(7,1)*5;ones(7,1)*6;ones(7,1)*7;...
    ones(7,1)*9;ones(7,1)*10;ones(7,1)*11];
figure
boxplot(EMGStack,EMGType)
