function powerFreqBand = powerFreqBand(powerSignal,F,frequencyBand,normalize)
if nargin == 1
    normalize = true;
end
fs = 1000;

powerFreqBand = zeros(length(frequencyBand)+2,size(powerSignal,2));
for j = 1 : size(powerSignal,2)
    powerTotal = sum(powerSignal(:,j));
    powerFreqBand(1,j) = powerTotal;
    if ~normalize 
        powerTotal = 1;
    end
    frequencyBandNew = [0;frequencyBand;fs/2];
    F_Low = 1;
    for i = 2 : length(frequencyBandNew)
        %F_Low = find(F>=frequencyBand(i-1), 1);
        F_High = find(F>=frequencyBandNew(i),  1);
        powerFreqBand(i,j) = sum(powerSignal(F_Low:F_High,j))/powerTotal;
        F_Low = F_High + 1;
    end
end
end