clear
clc 
load('damper_R12_lo.csv')

Fd = damper_R12_lo(:,1)';
vel = damper_R12_lo(:,2)';


% Joint damping
B = 1;
% out = sim('Main.slx',4);

% geometry 
length.geometry.innerface = 36;
% settings
% max = 38.4, min 4.6
length.settings.nut = 19;
length.setting.nutpos = length.geometry.innerface+length.settings.nut; 

% stroke lengths
length.stroke.minref = 153;
length.stroke.maxref = 199.63;
length.stroke.total = length.stroke.maxref - length.stroke.minref;
length.stroke.midref = length.stroke.minref + 0.5*length.stroke.total;
initial = length.stroke.midref -23.5-55;
length.stroke.min = -0.5*length.stroke.total;
length.stroke.max = 0.5*length.stroke.total;

% spring data
length.spring.free_length = 122;
length.spring.initial = length.stroke.midref-length.setting.nutpos-23.5;
coeff.spring.constant = 4.46; 

