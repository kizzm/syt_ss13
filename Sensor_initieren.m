% Sensor initieren

sensorkonstanten = sensorDaten([5,10,1000],(10/360*2*pi),[1,1]);

% Bsp: signal = sensor(5.1,'grad','linear',sensorkonstanten)
% Bsp: Position = posBerechnung(signal,sensorkonstanten)

Kennlinie('sensor.m',25,{'linear',sensorkonstanten});
Kennlinie('sensor.m',25,{'lineardif',sensorkonstanten});