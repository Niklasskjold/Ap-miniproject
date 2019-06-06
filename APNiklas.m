%Import audio file of a guitar 
[in,Fs]= audioread('Guitar.mp3'); %Input is a mono signal






%Delay (Feedforward):


%Delay Length
delayInSeconds = 1; % Changes length of delay in seconds
samplesOfDelay = delayInSeconds * Fs;% Seconds * (samples/seconds) = samples

%Gain. Changing amplitude of wetPath compared to dryPath
gain = 0.1; %Change volume of delay

%Zero-padding 
dryPath = [in; zeros(samplesOfDelay, 1)]; % Input signal with added zeros to match length of wetPath
wetPath = [zeros(samplesOfDelay, 1); in]; % Feeding input to out through delay block

out = zeros(size(dryPath));


%Adding paths together
for i = 1: length(dryPath)
    out (i,1) = dryPath(i,1) + gain * wetPath(i,1); %Adding gain
end


%Panning 

%Pan pot (panning potentiometer)

%Knob value from -10 to 10, where -10 is left and 10 is right, making 0 the
%center
panningValue = 0;

%Linear pan
right = panningValue/20 + 0.5; %panning value divided by total pan spectrum + offset
left = 1 - right;

%Assign to out signal from before
finalSignal = [left*out, right* out];

%Play output
sound(finalSignal,Fs);


