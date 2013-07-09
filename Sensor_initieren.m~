% Sensor initieren
addpath('/home/kizzm/Dokumente/Studium/Master_Photonik/Repos/syt_ss13/');

sensorkonstanten = sensorDaten([5,10,24000],(45/360*2*pi),[1,1]);

% Bsp: signal = sensor(5.1,'grad','linear',sensorkonstanten)
% Bsp: Position = posBerechnung(signal,sensorkonstanten)

%% Kennlinien
Kennlinie('sensor.m',100,{'einzelGruppe',sensorkonstanten});
Kennlinie('sensor.m',100,{'linear1',sensorkonstanten}); 
Kennlinie('sensor.m',100,{'linear2',sensorkonstanten}); 
Kennlinie('sensor.m',100,{'nonlinear',sensorkonstanten}); 

%% Daten ausgabe
Innenradius =5; % in mm
Aussenradius =10; % in mm
Lastwiederstand =24000; % in Ohm

Phototodioden = [Innenradius,Aussenradius,Lastwiederstand];
Messbereich = 10; % in rad
LEDLeistung = 10; % in W