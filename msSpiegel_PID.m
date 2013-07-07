%  msSpiegel.m     (Matlab/Simulink R2011b)
%
%  Vorgang:   Regelung eines Gleichstrommotors zur Spiegelverstellung
%  Verfahren: Simulink
%
%  Unterprogramme:  sSpiegel.slx
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
%
% ########################################################

clear all
close all

% Angabe der Parameter für Simulink für die weiteren Berechnungen
  RA=0.16;            %  (Nollau, S. 36)
  TA=2.8;           
  TA=TA*1e-3;         % ms -> s
  LA=RA*TA;        
  
  J=93.3e-9;          % kg m^2 Trägheitsmoment des Spiegels
             
  r=6e-5;             % Reibunsgkonstante
  
  KMPHI=6.3e-2;       % Motorkennzahl in Vs  
  
  Mspiegel=130.25e-3; % 130.25e-6Nm Spiegelmoment 
  
  te=.1;             
   
  uu=-30;             % uu=-10 N
  uo=30;              % uo=25 N 
  vu2=0;              % iu2=0 mA
  vo2=15*1e4;         % io2=15*1e4 mA 
  vu3=-0.4;           % phiu=-20° in rad
  vo3=0.4;            % phio=+20° in rad

% ########################################################

% Es wird ein maximaler Winkel von 20° zum einstellen vorgegeben.
phi = 20*pi/180; 

  vu4=phi-0.5e-2*pi/180;    % dient zur Anzeige der Regeldifferenz
  vo4=phi+0.5e-2*pi/180;    % dient zur Anzeige der Regeldifferenz
  
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

[t,x,y]=sim('sSpiegel',[t0 te],opts);


% Plots
subplot(3,1,1)
plot (t,y(:,1),'linewidth',2)  
axis([0 te uu uo])
grid on
hold on 
xlabel('t / s')
ylabel('u_e / V') 
title('Gleichstrommotor: Motorspannung,') 


subplot(3,1,2)
plot(t,y(:,5),t,phi,'linewidth',2,'linewidth',2);
axis([0 te vu3 vo3])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')

subplot(3,1,3)
plot(t,y(:,5),t,phi,t,(phi-1e-3*pi/180),t,(phi+1e-3*pi/180),'linewidth',2,'linewidth',2,'linewidth',2,'linewidth',2);
axis([0 te vu4 vo4])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')


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





