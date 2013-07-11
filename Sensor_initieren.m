% Funktionen die benötigt werden sind hier gespeichert
addpath('/home/kizzm/Master/Repos/syt_ss13/');

% Auswahl Sensorverhalten
global mode 
mode = 'linear1';
global Unit
Unit = 'rad';

% Kennwerte für Sensor
Innenradius =5; % in mm
Aussenradius =10; % in mm
Lastwiederstand =6000; % in Ohm

Photodioden = [Innenradius,Aussenradius,Lastwiederstand];
Messbereich = 20/180*pi; % 45° in rad
LEDLeistung = 1; % in W
Umgebungstemperatur = 300; % in K
nonlinear = 0.0001; % Wert zwischen 0 und 1

% Cell-Array für Kennwerte von Sensor
global Sensorkonstanten 
Sensorkonstanten = sensorDaten(Photodioden,Messbereich,LEDLeistung,Umgebungstemperatur,nonlinear);

% Bsp: signal = sensor(5.1,'grad','linear',sensorkonstanten)
% Bsp: Position = posBerechnung(signal,sensorkonstanten)

%% Kennlinien
mode = 'einzelGruppe';
Kennlinie('sensor.m',100,{'einzelGruppe',Sensorkonstanten});
mode = 'linear1';
Kennlinie('sensor.m',100,{'linear1',Sensorkonstanten}); 
mode = 'linear2';
Kennlinie('sensor.m',100,{'linear2',Sensorkonstanten}); 
mode = 'nonlinear';
Kennlinie('sensor.m',100,{'nonlinear',Sensorkonstanten}); 