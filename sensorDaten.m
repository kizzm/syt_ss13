%% Sensorkonstanten = sensorDaten(Photodioden,Blendenbreite,LED)
% Erzeugt:
%       [Out]:
%       Array der Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden
%           4 signal_max in V
%      
%       [In]:
%       Array der Diodendaten => Photodioden
%           1   Azimutwinkel                in rad     
%           2   Innererradius r1            in mm
%           3   Äußererradius r2            in mm
%       Breite der Blende => Blendenbreite  in rad
%       Array der LEDDaten => LED
%           1   LED Abstrahlcharakteristik  als Array
%           2   LED Abstand zu Dioden       in mm

function Sensorkonstanten = sensorDaten(Photodioden,Blendenbreite,LED)
Sensorkonstanten(1) = 1 % Fürs erste angenommen zu 1A
Sensorkonstanten(2) = 50 % 
Sensorkonstanten(3) =
Sensorkonstanten(4) =

end
