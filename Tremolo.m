function [out] = Tremolo(in,Fs,intensity,frequency)
%Time vector
time = [0:length(in)-1]/Fs; %In seconds
time = time(:);

%Intensity of tremolo effect
inten=intensity; %Intensity of effect. Default 0.
amplitude = intensity/200; % Depth is the amplitude of the modulator
offset = 1 -amplitude; %Offset depends on the amplitude of the modulator


%Modulator
freq=frequency;

tremolo=amplitude*sin(2*pi*freq*time) + offset; %Sine wave times amplitude and an offset

%Apply effect
out= in .* tremolo;
end