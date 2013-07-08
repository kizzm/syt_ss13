%% signal = sensor( Blendenwinkel, Unit, Verhalten, Sensorkonstanten)
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

Rauschen = rand()*Sensorkonstanten{1}/10;

switch Verhalten
    case 'einzelGruppe'
        
        a = @(phi) 1/Sensorkonstanten{3}/2 * phi + 0.5; % lineares Verhalten des Sensors +- °_max

        S1 = @(phi,d) Sensorkonstanten{1}/4*(a(phi))+d; % Signal der Sensor 1
        S3 = @(phi,d) Sensorkonstanten{1}/4*(a(phi))+d; % Signal der Sensor 3
        S2 = @(phi,d) Sensorkonstanten{1}/4*(1-a(phi))+d; % Signal Sensor 2
        S4 = @(phi,d) Sensorkonstanten{1}/4*(1-a(phi))+d; % Signal Sensor 4
        
        S13 = @(phi,d) S1(phi,d)+S3(phi,d);
        S24 = @(phi,d) S2(phi,d)+S4(phi,d);

        Iph = @(phi,d) S13(phi,d); % Gesammt Photostrom

        signal = Iph(phiB,Rauschen)/Sensorkonstanten{1}*Sensorkonstanten{4}; % Spannungssignal [Out]

    case 'lineardif'
        a = @(phi) 1/Sensorkonstanten{3} * phi + 0.5; % lineares Verhalten des Sensors +- °_max

        S1 = @(phi,d) Sensorkonstanten{1}/4*(a(phi))+d; % Signal der Sensor 1
        S3 = @(phi,d) -Sensorkonstanten{1}/4*(a(phi))+d; % Signal der Sensor 3
        S2 = @(phi,d) Sensorkonstanten{1}/4*(1-a(phi))+d; % Signal Sensor 2
        S4 = @(phi,d) -Sensorkonstanten{1}/4*(1-a(phi))+d; % Signal Sensor 4
        
        S13 = @(phi,d) S1(phi,d)-S3(phi,d);
        S24 = @(phi,d) S2(phi,d)-S4(phi,d);

        Iph = @(phi,d) S13(phi,d) - S24(phi,d); % Gesammt Photostrom
        signal = Iph(phiB,Rauschen)/Sensorkonstanten{1}*Sensorkonstanten{4}; % Spannungssignal [Out]
        
    case 'nonlinear'
        AP = Sensorkonstanten{6}-phiB;
        ind1 = find(AP==min(AP))
        ind2 = find(AP==min(AP(AP~=min(AP))))
        X1 = Sensorkonstanten{6}(ind1)
        X2 = Sensorkonstanten{6}(ind2)
        Y1 = Sensorkonstanten{8}(ind1)
        Y2 = Sensorkonstanten{8}(ind2)
        signal = (Y2-Y1)/(X2-X1)*phiB + (X2*Y1-X1*Y2)/(X2-X1)
end

%Signalbegrenzung
if signal > Sensorkonstanten{4}
    signal = Sensorkonstanten{4};
elseif signal < -Sensorkonstanten{4}
        signal = -Sensorkonstanten{4};
end

end