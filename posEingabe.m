%% sollsignal = posEingabe(phiPos)
% Erzeugt:
%       [Out]:
%       sollsignal
%       
%       [In]:
%       sollwinkel


function sollsignal = posEingabe(phi)

global Unit
global Sensorkonstanten

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

% if abs(phiPos) > Sensorkonstanten{3}
%     phiPos = Sensorkonstanten{3}*sign(phiPos);
% end
%         
sollsignal = (phiPos*1/(Sensorkonstanten{3})) * Sensorkonstanten{4};

end