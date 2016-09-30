load results/resultsNormalized
coherenceEMGZTrans = zeros(7,3,501);
coherenceEMGZTransPower = zeros(7,3);
frequencyBands = [6 ; 12];
F = resultsNormalized.F;
normalize = 1;
for i = 1 : 7
    emgCoherenceZTrans(i,1,:) = resultsNormalized.DF.EMGCoherence{i}(:,1);
    emgTQPower = powerFreqBand(resultsNormalized.DF.EMGCoherence{i}(:,1) ,F,frequencyBands,normalize);
    coherenceEMGZTransPower(i,1) = emgTQPower(3);
    emgCoherenceZTrans(i,2,:) = resultsNormalized.PF1.EMGCoherence{i}(:,1);
    emgTQPower = powerFreqBand(resultsNormalized.PF1.EMGCoherence{i}(:,1),F,frequencyBands,normalize);
    coherenceEMGZTransPower(i,2) = emgTQPower(3);
    emgCoherenceZTrans(i,3,:) = resultsNormalized.PF2.EMGCoherence{i}(:,1);
    emgTQPower = powerFreqBand(resultsNormalized.PF2.EMGCoherence{i}(:,1),F,frequencyBands,normalize);
    coherenceEMGZTransPower(i,3) = emgTQPower(3);
end

save results/emgTQCoherencePower coherenceEMGZTransPower emgCoherenceZTrans
%%
clear
load results/emgTQCoherencePower
clc
figure
subplot(2,1,1)
bar(coherenceEMGZTransPower)
subplot(2,1,2)
bar([1 2 3], mean(coherenceEMGZTransPower))
hold on
errorbar([1 2 3], mean(coherenceEMGZTransPower),std(coherenceEMGZTransPower),'r')