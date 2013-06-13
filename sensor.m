%% signal = sensor( Blendenwinkel, Unit, Sensorkonstanten)
% Erzeugt:
%       [Out]:
%       Normiertes Spannungssignal +-5V => signal in V
%       
%       [In]:
%       aus Eingangswinkel => Blendenwinkel in 
%       der angegebenen Einheit => Unit
%       Array aus Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden
%           4 signal_max in V
%       Unit cases: 'grad','mgrad','rad','mrad'

function signal = sensor(Blendenwinkel,Unit,Sensorkonstanten)

%% Abfrage der Eingangseinheit
switch Unit
    case 'grad'
        phiB = Blendenwinkel/180*pi;    
    case 'mgrad'
        phiB = Blendenwinkel/1000/180*pi;
    case 'rad'
        phiB = Blendenwinkel;
    case 'mrad'
        phiB = Blendenwinkel/1000;
end
        
a = @(phi) 1/(20/180*pi) * phi + 0.5; % lineares Verhalten des Sensors +- 10°

S13 = @(phi) Sensorkonstanten(1)*(a(phi)); % Signal der Sensoren 1+3
S24 = @(phi) Sensorkonstanten(1)*(1-a(phi)); % Signal der Sensoren 2+4

Iph = @(phi) S13(phi) - S24(phi); % Gesammt Photostrom

signal = Iph(phiB)/Sensorkonstanten(1)*Sensorkonstanten(4); % Spannungssignal [Out]
end