load stretchReflexResults
conditions = 1:3;
pulseMeanResults = [mean(results.PF2.pulseReflexAmplitude) mean(results.PF1.pulseReflexAmplitude) mean(results.DF.pulseReflexAmplitude)];
pulsePrctile20Results = [prctile(results.PF2.pulseReflexAmplitude,10) prctile(results.PF1.pulseReflexAmplitude,10) prctile(results.DF.pulseReflexAmplitude,10)];
pulsePrctile80Results = [prctile(results.PF2.pulseReflexAmplitude,90) prctile(results.PF1.pulseReflexAmplitude,90) prctile(results.DF.pulseReflexAmplitude,90)];
bar(conditions, pulseMeanResults)
labels = {'Plantarflexed position','Mid position','Dorsiflexed position'};
set(gca,'XTickLabel',labels)
ylabel('Stretch Reflex RMS')

%hold on
%errorbar(conditions,pulseMeanResults,pulsePrctile10Results-pulseMeanResults,pulsePrctile90Results-pulseMeanResults,'r')