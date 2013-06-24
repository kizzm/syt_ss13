%% signal = sensor( Blendenwinkel, Unit, Verhalten Sensorkonstanten)
% Erzeugt:
%       [Out]:
%       Normiertes Spannungssignal +-5V => signal in V
%       
%       [In]:
%       aus Eingangswinkel => Blendenwinkel in 
%       der angegebenen Einheit => Unit
%       Kennverhalten des Sensors => Verhalten
%       Array aus Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodiodennonlinear
%           4 signal_max in V
%       Unit cases: 'grad','mgrad','rad','mrad'
%       Verhalten cases : 'linear', ...

function signal = sensor(Blendenwinkel,Unit, Verhalten, Sensorkonstanten)

%% Umrechnung der Eingangseinheit
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

switch Verhalten
    case 'linear'
        a = @(phi) 1/(Sensorkonstanten{2}/180*2*pi) * phi + 0.5; % lineares Verhalten des Sensors +- °_max

        S13 = @(phi) Sensorkonstanten{1}*(a(phi)); % Signal der Sensoren 1+3
        S24 = @(phi) Sensorkonstanten{1}*(1-a(phi)); % Signal der Sensoren 2+4

        Iph = @(phi) S13(phi) - S24(phi); % Gesammt Photostrom

        signal = Iph(phiB)/Sensorkonstanten{1}*Sensorkonstanten{4}; % Spannungssignal [Out]
    case 'lineardif'
        Rauschen = rand();
        a = @(phi) 1/(Sensorkonstanten{2}/180*2*pi) * phi + 0.5; % lineares Verhalten des Sensors +- °_max

        S1 = @(phi,d) Sensorkonstanten{1}*(a(phi))+d; % Signal der Sensor 1
        S3 = @(phi,d) -Sensorkonstanten{1}*(a(phi))+d; % Signal der Sensor 3
        S2 = @(phi,d) Sensorkonstanten{1}*(1-a(phi))+d; % Signal Sensor 2
        S4 = @(phi,d) -Sensorkonstanten{1}*(1-a(phi))+d; % Signal Sensor 4
        
        S13 = @(phi,d) S1(phi,d)-S3(phi,d);
        S24 = @(phi,d) S2(phi,d)-S4(phi,d);

        Iph = @(phi,d) S13(phi,d) - S24(phi,d); % Gesammt Photostrom

        signal = Iph(phiB,Rauschen)/Sensorkonstanten{1}*Sensorkonstanten{4}; % Spannungssignal [Out]
        
    case 'char'
        Iph = @(phi) Sensorkonstanten{5}
end
end