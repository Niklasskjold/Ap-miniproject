%Import audio file of a guitar 
[in,Fs]= audioread('Guitar.mp3'); %Input is a mono signal

outDelay=Delay(in,Fs,0.25,0.2); % Inputs: In(audio input), Fs (sampling rate), delay in seconds, gain
outTremolo=Tremolo(in,Fs,100,5);% Inputs: Audio input, Fs, intensity in percent (from 0-100), frequency (from 0.1 to 10 Hz).


maximumDelay = ceil(.05*Fs); % Sets the max delay of chorus and reverb to 50 ms



%Chorus variables
chorusWetSignal = 50; % In percent. This is the wet signal.
chorusDepth = 5; % In milliseconds. This is the amplitude of the modulator
chorusPredelay = 30; % Also in milliseconds. This is to add an offset to the modulator, such that the delay is within 10-50 milliseconds.
chorusRate = 0.9; % In Hz, this the frequency of the modulator
chorusBuffer = zeros(maximumDelay,1);


%Reverb variables

revDelay = .04*Fs; %Sets the delay to 40 ms
revAmp = 6; %Range of 6 samples of delay
revRate = 0.6; %In Hz. This is the frequency of the modulator 
revGain = -0.7; %Sets the feedback gain of the reverb
revBuffer = zeros(maximumDelay,1);% The reverb effect buffer


%Output for chorus effect

lengthOfInChorus = length(in); %Length of the dry signal
outChorus = zeros(lengthOfIn,1);%Creates empty wet signal, with the length of the dry signal

%Here the signal is then processed with the chorus effect
for n = 1:lengthOfInChorus
[outChorus(n,1),chorusBuffer] = Chorus(in(n,1),chorusBuffer,Fs,n,chorusDepth,chorusRate,chorusPredelay,chorusWetSignal);%Inputs: In,Fs, Buffer for the chorus, the depth of the chorus, the rate of the chorus, the predelay of the chorus and the wet signal)
end

%Output for reverb effect 
lengthOfInReverb= length(in);
outReverb = zeros(lengthOfInReverb,1);

%Here the signal in then processed with the reverb effect
for n = 1:lengthOfInReverb
    [outReverb(n,1),revBuffer] = Reverb(in(n,1),revBuffer,Fs,n,revDelay,revGain,revAmp,revRate);
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
finalSignal = [left*outReverb, right* outReverb];

%Play output
sound(finalSignal,Fs);


