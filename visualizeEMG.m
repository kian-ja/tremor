load results/resultsNormalizedHPF
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
EMG_GSMed(4,2) = [0.145470885532520];
EMG_GSMed(5,2) = [0.498902514082208];
EMG_TA(i,3) = EMG_TA(i,3)./EMG_TA(i,1);
EMG_TA(i,2) = EMG_TA(i,2)./EMG_TA(i,1);
EMG_TA(i,1) = 1;

EMG_GSMed(i,3) = EMG_GSMed(i,3)./EMG_GSMed(i,1);
EMG_GSMed(i,2) = EMG_GSMed(i,2)./EMG_GSMed(i,1);
EMG_GSMed(i,1) = 1;

EMG_GSLat(i,3) = EMG_GSLat(i,3)./EMG_GSLat(i,1);
EMG_GSLat(i,2) = EMG_GSLat(i,2)./EMG_GSLat(i,1);
EMG_GSLat(i,1) = 1;

EMG_Sol(i,3) = EMG_Sol(i,3)./EMG_Sol(i,1);
EMG_Sol(i,2) = EMG_Sol(i,2)./EMG_Sol(i,1);
EMG_Sol(i,1) = 1;
%save results/EMG_RMS EMG_GSMed EMG_GSLat EMG_Sol EMG_TA
%%
pDF_MID = signrank(EMG_GSMed(:,1)',EMG_GSMed(:,2)');
pDF_PF = signrank(EMG_GSMed(:,1)',EMG_GSMed(:,3)');
pMID_PF = signrank(EMG_GSMed(:,3)',EMG_GSMed(:,2)');
disp(['EMG-GS Medial p value PF-MID is: ', num2str(pMID_PF)])
disp(['EMG-GS Medial p value PF-DF is: ', num2str(pDF_PF)])
disp(['EMG-GS Medial p value MID-DF is: ', num2str(pDF_MID)])

pDF_MID = signrank(EMG_GSLat(:,1)',EMG_GSLat(:,2)');
pDF_PF = signrank(EMG_GSLat(:,1)',EMG_GSLat(:,3)');
pMID_PF = signrank(EMG_GSLat(:,3)',EMG_GSLat(:,2)');
disp(['EMG-GS Medial p value PF-MID is: ', num2str(pMID_PF)])
disp(['EMG-GS Medial p value PF-DF is: ', num2str(pDF_PF)])
disp(['EMG-GS Medial p value MID-DF is: ', num2str(pDF_MID)])


pDF_MID = signrank(EMG_Sol(:,1)',EMG_Sol(:,2)');
pDF_PF = signrank(EMG_Sol(:,1)',EMG_Sol(:,3)');
pMID_PF = signrank(EMG_Sol(:,3)',EMG_Sol(:,2)');
disp(['EMG-GS Medial p value PF-MID is: ', num2str(pMID_PF)])
disp(['EMG-GS Medial p value PF-DF is: ', num2str(pDF_PF)])
disp(['EMG-GS Medial p value MID-DF is: ', num2str(pDF_MID)])

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
%%
emgCoherencePF2 = resultsNormalizedHPF.PF2.EMGCoherence;
emgCoherencePF1 = resultsNormalizedHPF.PF1.EMGCoherence;
emgCoherenceDF = resultsNormalizedHPF.DF.EMGCoherence;
emgGSMedPF2 = zeros(nSubjects,1);
emgGSLatPF2 = zeros(nSubjects,1);
emgSolPF2 = zeros(nSubjects,1);

emgGSMedPF1 = zeros(nSubjects,1);
emgGSLatPF1 = zeros(nSubjects,1);
emgSolPF1 = zeros(nSubjects,1);

emgGSMedDF = zeros(nSubjects,1);
emgGSLatDF = zeros(nSubjects,1);
emgSolDF = zeros(nSubjects,1);

for i = 1 : nSubjects
    emgCoherencePF2ThisSubject = emgCoherencePF2{i};
    emgGSMedCoherencePF2ThisSubject = emgCoherencePF2ThisSubject(:,1);
    emgGSLatCoherencePF2ThisSubject = emgCoherencePF2ThisSubject(:,2);
    emgSolCoherencePF2ThisSubject = emgCoherencePF2ThisSubject(:,3);
    emgGSMedPF2(i) = mean(emgGSMedCoherencePF2ThisSubject(6:13));
    emgGSLatPF2(i) = mean(emgGSLatCoherencePF2ThisSubject(6:13));
    emgSolPF2(i) = mean(emgSolCoherencePF2ThisSubject(6:13));
    
    emgCoherencePF1ThisSubject = emgCoherencePF1{i};
    emgGSMedCoherencePF1ThisSubject = emgCoherencePF1ThisSubject(:,1);
    emgGSLatCoherencePF1ThisSubject = emgCoherencePF1ThisSubject(:,2);
    emgSolCoherencePF1ThisSubject = emgCoherencePF1ThisSubject(:,3);
    emgGSMedPF1(i) = mean(emgGSMedCoherencePF1ThisSubject(6:13));
    emgGSLatPF1(i) = mean(emgGSLatCoherencePF1ThisSubject(6:13));
    emgSolPF1(i) = mean(emgSolCoherencePF1ThisSubject(6:13));
    
    emgCoherenceDFThisSubject = emgCoherenceDF{i};
    emgGSMedCoherenceDFThisSubject = emgCoherenceDFThisSubject(:,1);
    emgGSLatCoherenceDFThisSubject = emgCoherenceDFThisSubject(:,2);
    emgGSSolCoherenceDFThisSubject = emgCoherenceDFThisSubject(:,3);
    emgGSMedDF(i) = mean(emgGSMedCoherenceDFThisSubject(6:13));
    emgGSLatDF(i) = mean(emgGSLatCoherenceDFThisSubject(6:13));
    emgSolDF(i) = mean(emgGSSolCoherenceDFThisSubject(6:13));
end

EMGGsMed = [emgGSMedDF emgGSMedPF1 emgGSMedPF2];
EMGGsLat = [emgGSLatDF emgGSLatPF1 emgGSLatPF2];
EMGSol = [emgSolDF emgSolPF1 emgSolPF2];

emgDiff = EMGGsMed-EMGGsLat;
length(find(emgDiff>0))/21

emgDiff = EMGGsMed-EMGSol;
length(find(emgDiff>0))/21
