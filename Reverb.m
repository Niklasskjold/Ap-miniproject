function [outReverb,revBuffer] = Reverb(in,revBuffer,Fs, n,revDelay,revGain,revAmp,revRate)
%This reverberation effect uses the feedback comp filter as a block 

%Time for current sample 
time = (n-1)/Fs;
fDelay = revAmp* sin(2*pi*revRate*time);
iDelay = floor(fDelay);
f= fDelay-iDelay;

%Indexes for circular buffer
lengthOfBuffer = length(revBuffer);
index_1 = mod(n-1,lengthOfBuffer) + 1; %This is the current index
index_2 = mod(n-revDelay-1+iDelay,lengthOfBuffer) + 1; %This index contains the delay of the effect
index_3 = mod(n-revDelay-1+iDelay+1,lengthOfBuffer) + 1; %Fractional index to allow modulation of delay time 

%Add result to out signal
outReverb = (1-f)*revBuffer(index_2,1) + (f)*revBuffer(index_3,1);


%Then store the output in index
revBuffer(index_1,1) = in + revGain*outReverb;



end

