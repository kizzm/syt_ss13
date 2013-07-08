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

%Sensorcharakteristik mittels Fensterfunktionen für Blende und Photodiode
xmin = -2*pi;
xmax = 2*pi;
x = linspace(xmin,xmax,4000);
showmin = -pi/2;
showmax = pi/2;
c = 1;
e = 0.3;
b = pi/2;
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
end
