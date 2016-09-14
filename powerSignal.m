function [powerSignal,F] = powerSignal(signal,normalize)
%% Parameters
if nargin == 1
    normalize = true;
end
fs = 1000;
frequency = 0 : 1: fs/2;
overLap = 500;%1000
windowLength = 1000;%5000
%% Preprocessing
signal = signal - mean(signal);
[powerSignal,F] = pwelch(signal,gausswin(windowLength),overLap,frequency,fs);
if normalize 
    powerTotal = sum(powerSignal(:));
    powerSignal = powerSignal / powerTotal;
end
powerSignal = powerSignal';
end