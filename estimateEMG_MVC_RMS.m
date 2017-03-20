function EMG_MVC_RMS = estimateEMG_MVC_RMS(fileName, trialNumber)
    meanRemoved = false;
    data = flb2mat(fileName,'read_case',trialNumber);
    data = data.Data;
    emg = [abs(data(:,4)),abs(data(:,5)),abs(data(:,7))];
    if meanRemoved
        emg = emg - mean(emg);
    end
    visualSignal = data(:,9);
    emgMvc = extractEmgMvc(emg,visualSignal);
    EMG_MVC_RMS = rms(emgMvc);
end
function emgMvc = extractEmgMvc(emg,visualSignal)
    visualSignalOn = find(visualSignal>1);
    
end