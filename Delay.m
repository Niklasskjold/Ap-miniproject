function [out] = Delay(in,Fs,delayInSeconds, gain)

%Delay (Feedforward):


%Delay Length
delayS = delayInSeconds; % Changes length of delay in seconds
samplesOfDelay = delayS * Fs;% Seconds * (samples/seconds) = samples

%Gain. Changing amplitude of wetPath compared to dryPath
gainEcho = gain; %Change volume of delay

%Zero-padding 
dryPath = [in; zeros(samplesOfDelay, 1)]; % Input signal with added zeros to match length of wetPath
wetPath = [zeros(samplesOfDelay, 1); in]; % Feeding input to out through delay block

out = zeros(size(dryPath));


%Adding paths together
for i = 1: length(dryPath)
    out (i,1) = dryPath(i,1) + gain * wetPath(i,1); %Adding gain
end


end

