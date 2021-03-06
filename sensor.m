%% signal = sensor( Blendenwinkel, Unit, mode, Sensorkonstanten)
% Erzeugt:
%       [Out]:
%       Normiertes Spannungssignal +-5V => signal in V
%       
%       [In]:
%       aus Eingangswinkel => Blendenwinkel in 
%       der angegebenen Einheit => Unit
%       Kennmode des Sensors => mode
%       Array aus Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodiodennonlinear
%           4 signal_max in V
%       Unit cases: 'grad','mgrad','rad','mrad'
%       mode cases : 'linear', ...

function signal = sensor(Blendenwinkel)

global Unit
global mode
global Sensorkonstanten

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
%Rauschen aus Temperaturspannung
% kb = 8.6173324*10^-5; % eV/K
% e = 1; % eV
% T = Sensorkonstanten{9};
% RLast = Sensorkonstanten{2};
% zufall = 0.5-rand();
% UT = kb*T/e/RLast % in V
% Rauschen = UT+UT*zufall

Rauschen = rand()*Sensorkonstanten{1}/10;

switch mode
    case 'einzelGruppe'
        
        a=@(phi)1/Sensorkonstanten{3}/2*phi+0.5;% lineares Model

        S1=@(phi,d)Sensorkonstanten{1}*(a(phi))+d;% Signal Sensor 1
        S3=@(phi,d)Sensorkonstanten{1}*(a(phi))+d;% Signal Sensor 3
        S2=@(phi,d)Sensorkonstanten{1}*(1-a(phi))+d;% Signal Sensor 2
        S4=@(phi,d)Sensorkonstanten{1}*(1-a(phi))+d;% Signal Sensor 4
        
        S13=@(phi,d)S1(phi,d)+S3(phi,d);
        S24=@(phi,d)S2(phi,d)+S4(phi,d);

        Iph=@(phi,d)S13(phi,d);% Gesammt Photostrom

        signal=Iph(phiB,Rauschen)*Sensorkonstanten{2};% [Out]

    case 'linear1'
        a=@(phi)1/Sensorkonstanten{3}*phi+0.5;% lineares Model

        S1=@(phi,d)Sensorkonstanten{1}*(a(phi))+d;% Signal Sensor 1
        S3=@(phi,d)-Sensorkonstanten{1}*(a(phi))+d;% Signal Sensor 3
        S2=@(phi,d)Sensorkonstanten{1}*(1-a(phi))+d;% Signal Sensor 2
        S4=@(phi,d)-Sensorkonstanten{1}*(1-a(phi))+d;% Signal Sensor 4
        
        S13=@(phi,d)S1(phi,d)-S3(phi,d);
        S24=@(phi,d)S2(phi,d)-S4(phi,d);

        Iph=@(phi,d)S13(phi,d)-S24(phi,d); % Gesammt Photostrom
        signal=Iph(phiB,Rauschen)*Sensorkonstanten{2}; % [Out]
        
    case 'linear2'
        AP=abs(Sensorkonstanten{5}-phiB);
        ind1=find(AP==min(AP));
        ind2=find(AP==min(AP(AP~=min(AP))));
        X1=Sensorkonstanten{5}(ind1);
        X2=Sensorkonstanten{5}(ind2);
        Y1=Sensorkonstanten{7}(ind1);
        Y2=Sensorkonstanten{7}(ind2);
        
        I0=Sensorkonstanten{1}*4;
        Iph=@(phiB)I0*((Y2-Y1)/(X2-X1)*phiB+(X2*Y1-X1*Y2)/(X2-X1));
        signal=Iph(phiB)*Sensorkonstanten{2};
        
    case 'nonlinear'
        AP=abs(Sensorkonstanten{6}-phiB);
        ind1=find(AP==min(AP));
        ind2=find(AP==min(AP(AP~=min(AP))));
        X1=Sensorkonstanten{6}(ind1);
        X2=Sensorkonstanten{6}(ind2);
        Y1=Sensorkonstanten{8}(ind1);
        Y2=Sensorkonstanten{8}(ind2);
        
        I0=Sensorkonstanten{1}*4;
        Iph=@(phiB)I0*((Y2-Y1)/(X2-X1)*phiB+(X2*Y1-X1*Y2)/(X2-X1));
        signal=Iph(phiB)*Sensorkonstanten{2};
end

%Signalbegrenzung
if signal > Sensorkonstanten{4}
    signal = Sensorkonstanten{4};
elseif signal < -Sensorkonstanten{4}
        signal = -Sensorkonstanten{4};
end

end