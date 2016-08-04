load stretchReflexTrials
numSubject = length(experiment.PF2.MVC{1});
for i = 1 : numSubject
    pulseTrials = experiment.DF.pulseTrials{i};
    for j = 1 : length(pulseTrials)
        torque = flbReadTorque(experiment.fileName{i},pulseTrials(j));
    end
end