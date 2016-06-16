function powerFreqBand = powerFreqBand(powerSignal,F,frequencyBand,normalize)
if nargin == 1
    normalize = true;
end
fs = 1000;

powerFreqBand = zeros(length(frequencyBand)+2,1);
powerTotal = sum(powerSignal(:));
powerFreqBand(1) = powerTotal;
if ~normalize 
    powerTotal = 1;
end
frequencyBand = [0;frequencyBand;fs/2];
F_Low = 1;
for i = 2 : length(frequencyBand)
    %F_Low = find(F>=frequencyBand(i-1), 1);
    F_High = find(F>=frequencyBand(i),  1);
    powerFreqBand(i) = sum(powerSignal(F_Low:F_High))/powerTotal;
    F_Low = F_High + 1;
end
end