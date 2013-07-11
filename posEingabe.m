%% sollsignal = posEingabe(phiPos,Sensorkonstanten)
% Erzeugt:
%       [Out]:
%       sollsignal
%       
%       [In]:
%       Normiertes Spannungssignal des Sensors +-5V => signal in V
%       Array der Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden
%           4 signal_max in V
function sollsignal = posEingabe(phi,Unit,Sensorkonstanten)

switch Unit
    case 'grad'
        phiPos = phi/180*pi;    
    case 'mgrad'
        phiPos = phi/1000/180*pi;
    case 'rad'
        phiPos = phi;
    case 'mrad'
        phiPos = phi/1000;
end

if abs(phiPos) > Sensorkonstanten{3}
    phiPos = Sensorkonstanten{3}*sign(phiPos);
end
        
sollsignal = (phiPos * 1/(2*Sensorkonstanten{3})+0.5) * Sensorkonstanten{4};

end