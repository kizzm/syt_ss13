%% Sensorkonstanten = sensorDaten(Photodioden,
%                                 Messbereich,
%                                 LEDLeistung,
%                                 Umgebungstemperatur)
% Erzeugt:
%       [Out]:
%       Array der Sensorkonstanten => Sensorkonstanten
%           1 signal_max in A
%           2 Lastwiederstand der Idealen Photodiode in Ohm
%           3 Azimutwinkel der Photodioden/Maximaler Messbereich in rad
%           4 signal_max in V
%           5 X Koordinaten der liniaren Kennlinie
%           6 X Koordinaten der nicht liniaren Kennlinie
%           7 Y- / Funktions-Werte der liniaren Kennline
%           8 Y- / Funktions-Werte der nicht liniaren Kennline
%      
%       [In]:
%       Array der Diodendaten(geometrisch, elektrisch) => Photodioden
%           1   Innererradius r1            in mm
%           2   Äußererradius r2            in mm
%           3   Lastwiederstand             in Ohm
%
%       Maximal messbarer Winkel +- => Messbereich in rad
%
%       maximale Leistung der LED auf einer Diode => LEDLeistung in W
%       Umgebungstemperatur => Umgebungstemperatur in K
   
function Sensorkonstanten = sensorDaten(Photodioden,...
                                        Messbereich,...
                                        LEDLeistung,...
                                        Umgebungstemperatur,...
                                        nonlinear)
Sensorkonstanten{1}=sqrt(LEDLeistung/Photodioden(3)); % max Strom
Sensorkonstanten{2}=Photodioden(3); % Lastwiderstand
Sensorkonstanten{3}=Messbereich; % max Messbereich
Sensorkonstanten{4}=Sensorkonstanten{1}*Photodioden(3)*4;%max Spannung

%Sensorcharakteristik mittels Faltung von Fensterfunktionen
xmin = -2*pi;
xmax = 2*pi;
x = linspace(xmin,xmax,4000);

c = 1;
e = nonlinear;
b = Messbereich*2;
pb = 0;
ps1 = b/2;
g = [];
r = [];
s1 = [];
s2 = [];
for i = x
    r(end+1) = frect(i,b,pb);
    s1(end+1) = frect(i,b,ps1);
    s2(end+1) = frect(i,b,-ps1);
end
r = 1-r;
s1 = 1-s1;
s2 = 1-s2;
f1 = conv(r,s1);
f1 = f1./max(f1);
x21 = linspace(2*min(x),2*max(x),size(f1,2));
f2 = conv(r,s2);
f2 = f2./max(f2);
Sensorkonstanten{5} = linspace(2*min(x),2*max(x),size(f2,2));
for i = x21
	g(end+1) = gekern(i,e,c);
end
g = g./max(g);

gf1 = conv(g,f1);
gf1 = gf1./max(gf1);
gf2 = conv(g,f2);
gf2 = gf2./max(gf2);
Sensorkonstanten{6} = linspace(4*min(x),4*max(x),size(gf1,2));
f = f1-f2;
Sensorkonstanten{7} = f./max(f);
gf = gf1-gf2;
Sensorkonstanten{8} = gf./max(gf);

Sensorkonstanten{9} = Umgebungstemperatur;

end
