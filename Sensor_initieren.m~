% Sensor initieren
addpath('/home/kizzm/Dokumente/Studium/Master_Photonik/Repos/syt_ss13/');

sensorkonstanten = sensorDaten([5,10,6000],(45/360*2*pi),1,300);

% Bsp: signal = sensor(5.1,'grad','linear',sensorkonstanten)
% Bsp: Position = posBerechnung(signal,sensorkonstanten)

%% Kennlinien
Kennlinie('sensor.m',100,{'einzelGruppe',sensorkonstanten});
Kennlinie('sensor.m',100,{'linear1',sensorkonstanten}); 
Kennlinie('sensor.m',100,{'linear2',sensorkonstanten}); 
Kennlinie('sensor.m',100,{'nonlinear',sensorkonstanten}); 

%% Daten ausgabe (oder: so liefert der Sensor ein Spannungssignal)
mode = 'nonlinear';

Innenradius =5; % in mm
Aussenradius =10; % in mm
Lastwiederstand =6000; % in Ohm

Phototodioden = [Innenradius,Aussenradius,Lastwiederstand];
Messbereich = 45/180*pi; % 45° in rad
LEDLeistung = 1; % in W
Umgebungstemperatur = 300; % in K

sensorkonstanten = (Photodioden,Messbereich,LEDLeistung,Umgebungstemperatur);

%erzeugen eines Messwerts
phi = 0.4 ; %Beispielwinkel der Welle in rad
signal = sensor(phi,'rad',mode,sensorkonstanten)