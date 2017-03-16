figure
clear
clc
subplot(1,2,1)
positionValuesMM2000 = [-0.48 -0.4 -0.32 -0.24 -0.16 -0.08 0 0.08 0.16 0.24];
stiffnessValuesMM2000 = [0.42 0.39 0.45 0.5 0.53 0.5625 0.625 0.7 0.83 1];
stiffnessValuesMM2000 = stiffnessValuesMM2000 - min(stiffnessValuesMM2000);
stiffnessValuesMM2000 = stiffnessValuesMM2000 / max(stiffnessValuesMM2000);
p = polyfit (positionValuesMM2000,stiffnessValuesMM2000,7);
positionExperimental = [-0.35 -0.1 0.15];
stiffnessExperimentalFromMM2000 = polyval(p,positionExperimental);

plot(positionValuesMM2000,stiffnessValuesMM2000,'--o')
hold on
plot(positionExperimental,stiffnessExperimentalFromMM2000,'o')
subplot(1,2,2)
stretchReflexValuesMM2000 = [0.06 0.09 0.125 0.128 0.29 0.5 0.625 0.7 0.82 0.83];
stretchReflexValuesMM2000 = stretchReflexValuesMM2000 - min(stretchReflexValuesMM2000);
stretchReflexValuesMM2000 = stretchReflexValuesMM2000 / max(stretchReflexValuesMM2000);
plot(positionValuesMM2000,stretchReflexValuesMM2000,'--o')
p = polyfit (positionValuesMM2000,stretchReflexValuesMM2000,7);
positionExperimental = [-0.35 -0.1 0.15];
stretchReflexExperimentalFromMM2000 = polyval(p,positionExperimental);
hold on
plot(positionExperimental,stretchReflexExperimentalFromMM2000,'o')
figure
subplot(1,2,1)
bar(stiffnessExperimentalFromMM2000(end:-1:1))
subplot(1,2,2)
bar(stretchReflexExperimentalFromMM2000(end:-1:1))