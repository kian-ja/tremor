clear
clc
close all
load experimentTrials
subject = 1;
data = flb2mat(experiment.fileName{subject},'read_case',