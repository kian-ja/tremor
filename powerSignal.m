function [powerSignal,F] = powerSignal(signal,normalize)
%% Parameters
if nargin == 1
    normalize = true;
end
fs = 1000;
frequency = 0 : 1: fs/2;
overLap = 1000;%500
windowLength = 5000;%1000
%% Preprocessing
signal = signal - mean(signal);
[powerSignal,F] = pwelch(signal,gausswin(windowLength),overLap,[],fs);
if normalize 
    powerTotal = sum(powerSignal(:));
    powerSignal = powerSignal / powerTotal;
end
%powerSignal = powerSignal';
end