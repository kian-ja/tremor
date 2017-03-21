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
    visualSignalOnIndex = find(visualSignal>1);
    emgMvc = findEmgOn(emg,visualSignalOnIndex);
end
function emgMvc = findEmgOn(emg,visualSignalOnIndex)
    mvcIndex = findLongSegments(visualSignalOnIndex);
    emgMvc = zeros(length(mvcIndex),size(emg,2));
    for i = 1 : size(emg,2)
        emgMvc(:,i) = emg(mvcIndex,i);
    end
end

function longSegmentIndex = findLongSegments(segmentIndex,indexJumpThreshold,segmentLengthThreshold,initialSamplesSkip)
    if nargin<2
        indexJumpThreshold = 1000;%1 second for 1kHz
        segmentLengthThreshold = 2500;
        initialSamplesSkip = 750;
    end
    segmentIndexDiff = segmentIndex(2:end)-segmentIndex(1:end-1);
    jumpIndex = find(segmentIndexDiff > indexJumpThreshold);
    segmentEnd = segmentIndex(jumpIndex);
    segmentStart = segmentIndex(jumpIndex + 1);
    segmentStart = [segmentIndex(1);segmentStart];
    segmentEnd = [segmentEnd;segmentIndex(end)];
    segmentLength = segmentEnd - segmentStart;
    longSegmentIndex =[];
    for i = 1 : length(segmentLength)
        if segmentLength(i) > segmentLengthThreshold
            longSegmentIndex = [longSegmentIndex;[segmentStart(i) + initialSamplesSkip:1:segmentEnd(i)]'];
        end
    end
end