function [outChorus,chorBuffer] = Chorus(in,chorBuffer,Fs,n,chorDepth,chorRate,chorPredelay,chorWetSignal)

%Time in seconds for the current sample 
time = (n-1)/Fs;
lfoMS = chorDepth * sin(2*pi*chorRate*time) + chorPredelay;
lfoSam = (lfoMS/1000)*Fs;

% The dry and wet mix, ranges from 0-100 percent, where 0 is dry and 100 is
% wet
mixP = chorWetSignal;
mix = mixP/100;


fDelay = lfoSam;%Delay index
iDelay = floor(fDelay); %Fractional delay index

f = fDelay - iDelay;

% Store dry and wet signals
dry = in;
wet = (1-f)*chorBuffer(iDelay,1) + (f)*chorBuffer(iDelay+1,1);

% Blends the parralel paths, where dry is unprocessed and wet is the
% vibrato effect 
outChorus = (1-mix)*dry + mix*wet;

% Linear buffer 
chorBuffer = [in ; chorBuffer(1:end-1,1)];


end

