%  msSpiegel_Pad.m     (Matlab/Simulink R2011b)
%
%  Vorgang:   Regelung eines Gleichstrommotors zur Spiegelverstellung
%  Verfahren: Simulink, mithilfe einer P-Adaption, eingebauter Strom-
%             begrenzung, angepasster Motorenwerte und eingebauter
%             Sensor
%
%  Unterprogramme:  sSpiegelPadStromNeu.slx
%                   sensor.m
%                   posEingabe.m
%
% ########################################################
%
%  Parameterbeschreibung:
%
%   RA          Ankerwiderstand
%   LA          Ankerinduktivität
%
%   J           Traegheitsmoment
%   r           Reibkonstante
%
%   MSpiegel    Drehmoment für Spiegel
%
%   KMPHI       Motorkenngrösse
%
%   phi         Sprunghöhe Motorwinkel
%
%   te          Ende des Integrationsintervalls (ab t=0)
%
%   xuX, xoX    Untere/obere Grenze der Grafiken
%0
% ########################################################
clear all
close all

% Funktionen die benoetigt werden sind hier gespeichert
addpath('/home/michamann/git/syt_ss13/');

% Auswahl Sensorverhalten
global mode 
mode = 'nonlinear';           % linear1, linear2, nonlinear
global Unit
Unit = 'rad';

% Kennwerte fuer Sensor
Innenradius =5;             % in mm
Aussenradius =10;           % in mm
Lastwiederstand =6000;      % in Ohm

Photodioden = [Innenradius,Aussenradius,Lastwiederstand];
Messbereich = 20/180*pi;    % 45° in rad
LEDLeistung = 1;            % in W
Umgebungstemperatur = 300;  % in K
nonlinear = 0.0001;         % Wert zwischen 0 und 1

% Cell-Array fuer Kennwerte von Sensor
global Sensorkonstanten 
Sensorkonstanten = sensorDaten(Photodioden,...
                               Messbereich,...
                               LEDLeistung,...
                               Umgebungstemperatur,...
                               nonlinear);


% Angabe der Parameter fuer Simulink fuer die weiteren Berechnungen
  RA=0.1;                   % Innenwiderstand
  LA=3e-6;                  % Induktivitaet
  TA=LA/RA;                 % Zeitkonstante T1
  
  J=93.3e-11;               % kg m^2 Traegheitsmoment des Spiegels
  r=6e-5;                   % Nm*s Reibung
  
  KMPHI=35e-3;              % Vs Motorkonstante
  
  MSpiegel=30.25e-6;        % Nm Drehmoment fuer Spiegel
  
  te=.002;                  % end of simulation time 
   
  phi = 19*pi/180;          % einzustellender Winkel
  
  vu=-30;                   % uu=-30 V
  vo=30;                    % uo=+30 V
  iu=-15;                   % iu=-15 A
  io=+15;                   % io=+15 A 
  pu1=-1;                   % phiu=-20° in rad 0.4
  po1=1;                    % phio=+20° in rad -0.4
  pu2=phi-0.5e-2*pi/180;    % Diagrammgrenzen fuer Regeldifferenz
  po2=phi+0.5e-2*pi/180;    % Diagrammgrenzen fuer Regeldifferenz
  
% ########################################################

% Plot: Eingangssignal u und Winkel phi
figure(1)
set(gcf,'Units','normal','Position',[.49 .7 .5 .9], ...
    'NumberTitle','on','Name','u und v ');

%  Integrationsalgorithmus:
t0=0;
opts=simset('solver','ode45',...
    'InitialState',[],...
    'Refine',1,...
    'MaxStep',.00001);

[t,x,y]=sim('sSpiegelPadStromSensor',[t0 te],opts);

% Plots
subplot(3,1,1)
plot (t,y(:,1),'linewidth',2)  
axis([0 te vu vo])
grid on
hold on
xlabel('t / s')
ylabel('u_e / V') 
title('Gleichstrommotor: Motorspannung,') 

subplot(3,1,2)
plot(t,y(:,2),t,phi,'linewidth',2,'linewidth',2);
axis([0 te pu1 po1])
grid on
xlabel('t / s')
ylabel('Phi / rad')
YTicks=get(gca,'YTick');
set(gca,'YTickLabel',num2str(YTicks(:),'%.1f'));
title('Gleichstrommotor: Winkel mit Sollwinkel')

subplot(3,1,3)
plot(t,y(:,2),...
     t,phi,...
     t,(phi-1e-3*pi/180),...
     t,(phi+1e-3*pi/180),...
     'linewidth',2,...
     'linewidth',2,...
     'linewidth',2,...
     'linewidth',2);
axis([0 te pu2 po2])
grid on
xlabel('t / s')
ylabel('Phi / rad')
YTicks=get(gca,'YTick');
set(gca,'YTickLabel',num2str(YTicks(:),'%.5e'));
title('Gleichstrommotor: Sollwinkel mit Regeldifferenz')


% Möglichkeit, Strom und Winkelspannunge auszugeben

% figure(2)
% plot (t,y(:,4),'linewidth',2);
% axis([0 te iu io])
% grid on
% xlabel('t / s')
% ylabel('i_A / A')
% title('Gleichstrommotor: Motorstrom')
% figure(2)
% plot (t,y(:,7),'linewidth',2);
% axis([0 te vu vo])
% grid on
% xlabel('t / s')
% ylabel('U / V')
% title('Sensor: aktuelle Winkelspannung')
% figure(3)
% plot (t,y(:,6),'linewidth',2);
% axis([0 te vu vo])
% grid on
% xlabel('t / s')
% ylabel('U / V')
% title('Eingabe: Sollwinkelspannung')

% Plot der variablen Schrittweite
% ht=diff(t)';
% ht=[ht ht(end)]';
% set(gcf,'Units','normal','Position',[.1 .2 .4 .2], ...
%     'NumberTitle','on','Name','h ');
% plot (t,ht,'x','markersize',9,'linewidth',2);
% grid on
% xlabel('t / s')
% ylabel('h / s')
% title('Schrittweite')
%end