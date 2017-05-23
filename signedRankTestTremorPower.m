%%
%New sign rank test
clear
load results/tremorTotalPower
%%
tremorPowerDF = tremorPowerHPF(:,1);
tremorPowerPF1 = tremorPowerHPF(:,2);
tremorPowerPF2 = tremorPowerHPF(:,3);
tremorPowerPF1 = tremorPowerPF1./tremorPowerDF;
tremorPowerPF2 = tremorPowerPF2./tremorPowerDF;
tremorPowerDF = tremorPowerDF./tremorPowerDF;

pDF_MID = signrank(tremorPowerDF,tremorPowerPF1);
pDF_PF = signrank(tremorPowerDF,tremorPowerPF2);
pMID_PF = signrank(tremorPowerPF2,tremorPowerPF1);
disp(['Tremor power p value PF-MID is: ', num2str(pMID_PF)])
disp(['Tremor power p value PF-DF is: ', num2str(pDF_PF)])
disp(['Tremor power p value MID-DF is: ', num2str(pDF_MID)])