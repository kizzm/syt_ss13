%% phiPos = posBerechnung(signal,Sensorkonstanten)
% Erzeugt:
%       [Out]:
%       Winkelposition => phiPos in rad
%       
%       [In]:
%       Normiertes Spannungssignal des Sensors +-5V => signal in V
%       Array der Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden
%           4 signal_max in V
function phiPos = posBerechnung(signal,Sensorkonstanten)

phiPos = Sensorkonstanten(3)/2 * signal/Sensorkonstanten(1);

end