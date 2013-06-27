%% Sensorkonstanten = sensorDaten(Photodioden,Blendenbreite,LED)
% Erzeugt:
%       [Out]:
%       Array der Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden/Maximaler Messbereich in rad
%           4 signal_max in V
%      
%       [In]:
%       Array der Diodendaten(geometrisch, elektrisch) => Photodioden
%           1   Innererradius r1            in mm
%           2   Äußererradius r2            in mm
%           3   Lastwiederstand             in Ohm
%
%       Maximal messbarer Winkel +- => Messbereich in rad
%
%       Array der LEDDaten => LED
%           1   LED Abstrahlcharakteristik  als Array
%           2   LED Abstand zu Dioden       in mm  
   
function Sensorkonstanten = sensorDaten(Photodioden,Messbereich,LED)
Sensorkonstanten{1} = 0.001; % Fürs erste angenommen zu 1A
Sensorkonstanten{2} = Photodioden(3); % Lastwiederstand
Sensorkonstanten{3} = Messbereich; % max Messbereich
Sensorkonstanten{4} = Sensorkonstanten{1}*Photodioden(3); % max Signal in V

end
