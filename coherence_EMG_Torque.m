function [CC,F] = coherence_EMG_Torque(EMG,torque,F,zTransform)
%% parameters and initalization
if (nargin == 3)
    zTransform = true;
end
numSamples = length(torque);

fs = 1000;
frequency = 0 : 1: fs/2;
overLap = 0;%500;%3500;%1000
windowLength = 1000;%5000;%5000
numSegments = floor(numSamples / windowLength);
%% Main function
num_EMG_channel = size(EMG,2);
CC = zeros(length(F),num_EMG_channel);
for i = 1 : num_EMG_channel
    %[CC(:,i),F] = mscohere(EMG(:,i),torque,gausswin(windowLength),overLap,frequency,fs);
    [CC(:,i),F] = mscohere(EMG(:,i),torque,rectwin(windowLength),overLap,frequency,fs);
    if zTransform
        coherence = atanh(sqrt(CC(:,i)));
        zStandard = coherence / sqrt (1 / 2 / numSegments );
        zStandard = normalizeZ(zStandard,F);
        CC(:,i) = zStandard;
    end
end
end
function zStandard = normalizeZ(z,F)
    frequencyIndex = findFrequencyIndexZBaseline(F);
    baseline = mean(z(frequencyIndex));
    zStandard = z - baseline;
    zStandard = max(zStandard,0);
end
function frequencyIndex = findFrequencyIndexZBaseline(F,remove60HZ_Harmonics,frequencyStart,frequencyEnd)
    if nargin<2
        remove60HZ_Harmonics = true;
        frequencyStart = 100;
        frequencyEnd = 300;
    end
    if remove60HZ_Harmonics
        harmonics60Hz = generateHarmonics(F,60);
        frequencyIndex = find((F>frequencyStart)&(F<frequencyEnd));
        frequencyIndex = removeElementFromArray(frequencyIndex,harmonics60Hz);
    else
    end
end
function harmoncis = generateHarmonics(frequencyAxis,fundamentalFrequency)
    maxHarmonics = floor(frequencyAxis(end)/fundamentalFrequency);
    harmoncis = 1 : maxHarmonics;
    harmoncis = harmoncis * fundamentalFrequency;
end
function arrayOut = removeElementFromArray(arrayIn,numbersToRemove,threshold)
    if nargin<3
        threshold = 2;
    end
    arrayOut = arrayIn;
    for i = 1 : length(numbersToRemove)
        numberToRemove = numbersToRemove(i);
        indexToRemove = find(abs(arrayOut-numberToRemove) < threshold);
        arrayOut(indexToRemove) = [];
    end
end