%  msSpiegel_Pad.m     (Matlab/Simulink R2011b)
%
%  Vorgang:   Regelung eines Gleichstrommotors zur Spiegelverstellung
%  Verfahren: Simulink, mithilfe einer P-Adaption
%
%  Unterprogramme:  sSpiegelPad.slx
%
% ########################################################
%
%  Parameterbeschreibung:
%
%   RA          Ankerwiderstand
%   LA          Ankerinduktivität
%
%   J           Trägheitsmoment
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
%
% ########################################################

clear all
close all

% Angabe der Parameter für Simulink für die weiteren Berechnungen

  RA=0.16;              % Widerstand (Nollau, S. 36)
  TA=2.8;               % Zeitkonstante
  TA=TA*1e-3;           % ms -> s
  LA=RA*TA;             % Induktivität
  
  J=93.3e-9;            % kg m^2 Trägheitsmoment des Spiegels
  
  r=6e-5;               % Nm*s
  
  KMPHI=6.3e-2;         % KMPHI= Vs  35e-3
  
  MSpiegel=130.25e-3;   % Drehmoment für Spiegel
  
  te=.05;               % end of simulation time 
   
  phi = 20*pi/180;      % einzustellender Winkel von 20°
  
  vu=-30;               % uu=-30 V
  vo=30;                % uo=+30 V
  wu1=-0.4;             % phiu=-20° in rad
  wo1=0.4;              % phio=+20° in rad
  wu2=phi-1e-1*pi/180;  % dient zur Anzeige der Regeldifferenz
  wo2=phi+1e-1*pi/180;  % dient zur Anzeige der Regeldifferenz

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

[t,x,y]=sim('sSpiegelPad',[t0 te],opts);


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
axis([0 te wu1 wo1])
grid on
xlabel('t / s')
ylabel('Phi / rad')
YTicks=get(gca,'YTick');
set(gca,'YTickLabel',num2str(YTicks(:),'%.1f'));
title('Gleichstrommotor: Winkel mit Sollwinkel')

subplot(3,1,3)
plot(t,y(:,2),t,phi,t,(phi-1e-3*pi/180),t,(phi+1e-3*pi/180),'linewidth',...
    2,'linewidth',2,'linewidth',2,'linewidth',2);
axis([0 te wu2 wo2])
grid on
xlabel('t / s')
ylabel('Phi / rad')
YTicks=get(gca,'YTick');
set(gca,'YTickLabel',num2str(YTicks(:),'%.5e'));
title('Gleichstrommotor: Sollwinkel mit Regeldifferenz')

% Plot der variablen Schrittweite
% ht=diff(t)';
% ht=[ht ht(end)]';
% figure(3)
% set(gcf,'Units','normal','Position',[.1 .2 .4 .2], ...
%     'NumberTitle','on','Name','h ');
% plot (t,ht,'x','markersize',9,'linewidth',2);
% grid on
% xlabel('t / s')
% ylabel('h / s')
% title('Schrittweite')
%end





