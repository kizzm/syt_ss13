%  msSpiegel_Pad.m     (Matlab/Simulink R2011b)
%
%  Vorgang:   Regelung eines Gleichstrommotors zur Spiegelverstellung
%  Verfahren: Simulink, mithilfe einer P-Adaption
%
%  Unterprogramme:  sSpiegelPadStrom.slx
%
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
%   KMPHI       Motorkenngrösse
%
%   uephi       Sprunghöhe Motorwinkel
%
%   te          Ende des Integrationsintervalls (ab t=0)
%
%   ug, og      Untere/obere Grenze der Grafiken
%0
% ########################################################

clear all
close all

% Angabe der Parameter für Simulink für die weiteren Berechnungen

  RA=0.1;             % Innenwiderstand des Galvos
  LA=3e-6;            % Induktivität des Galvos
  TA=LA/RA;           % Zeitkonstante T1
  
  J=93.3e-11;         % kg m^2 Trägheitsmoment des Spiegels
  r=6e-5;             % Nm*s
  
  KMPHI=35e-3;        % Vs
  
  Mspiegel=30.25e-6;  % Nm Drehmoment für Spiegel
  
  te=.002;            % end of simulation time 
   
  phi = 20*pi/180;    % einzustellender Winkel von 20°
  
  vu=-30;             % uu=-30 V
  vo=30;              % uo=+30 V
  iu=-15;             % iu=-15 A
  io=+15;             % io=+15 A 
  pu1=-0.4;           % phiu=-20° in rad
  po1=0.4;            % phio=+20° in rad
  pu2=phi-0.5e-2*pi/180;% Diagrammgrenzen für Regeldifferenz
  po2=phi+0.5e-2*pi/180;% Diagrammgrenzen für Regeldifferenz

% ########################################################
  
% Plot: Eingangssignal u
figure(1)
set(gcf,'Units','normal','Position',[.49 .7 .5 .9], ...
    'NumberTitle','on','Name','u und v ');


%  Integrationsalgorithmus:
t0=0;
opts=simset('solver','ode45',...
    'InitialState',[],...
    'Refine',1,...
    'MaxStep',.00001);

[t,x,y]=sim('sSpiegelPadStrom',[t0 te],opts);


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
plot(t,y(:,5),t,phi,'linewidth',2,'linewidth',2);
axis([0 te pu1 po1])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')

subplot(3,1,3)
plot(t,y(:,5),t,phi,t,(phi-1e-3*pi/180),t,(phi+1e-3*pi/180),'linewidth',2,'linewidth',2,'linewidth',2,'linewidth',2);
axis([0 te pu2 po2])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')

figure(2)
plot (t,y(:,4),'linewidth',2);
axis([0 te iu io])
grid on
xlabel('t / s')
ylabel('i_A / A')
title('Gleichstrommotor: Motorstrom')


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




