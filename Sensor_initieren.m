% Sensor initieren

sensorkonstanten = sensorDaten([5,10,24000],(10/360*2*pi),[1,1]);

% Bsp: signal = sensor(5.1,'grad','linear',sensorkonstanten)
% Bsp: Position = posBerechnung(signal,sensorkonstanten)

Kennlinie('sensor.m',100,{'einzelGruppe',sensorkonstanten});
Kennlinie('sensor.m',100,{'lineardif',sensorkonstanten}); 