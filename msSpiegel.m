%  msSpiegel.m     (Matlab/Simulink R2011b)
%
%  Vorgang:   Regelung eines Gleichstrommotors zur Spiegelverstellung
%  Verfahren: Simulink
%
%  Unterprogramme:  sSpiegel.slx
%
%  (c)25.3.12  R.Froriep
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
%P Anteil von 800
% ########################################################
clear all
close all
% Angabe der Parameter für Simulink für die weiteren Berechnungen
  RA=0.16;         % R=.1 Ohm  (Nollau, S. 36)
  TA=2.8;           % TA=2.8 ms
  TA=TA*1e-3;     % ms -> s
  LA=RA*TA;        %   173e-6 10e-6
  %TA=LA/RA;
  
  J=93.3e-9;           % J=93.3e-9(12) kg cm^2
  %J=J*1e-2*1e-2;  % cm -> m
  r=6e-5;         % r=6e-6 Nm*s
  
  KMPHI=6.3e-2;    % KMPHI= Vs  35e-3
  
  % uephi=0.1;        % verstellwinkel vorher: uedach=u_nenn=24V
  Mspiegel=130.25e-3; % MLdach=M_nenn=(1.6Nm) 130.25e-6Nm Spiegelmoment 
  
  te=.01;            % te=.1s 
   
  uu=-30;           % uu=-10 N
  uo=30;            % uo=25 N 
  vu=-1000;         % wu=-1000 U/s
  vo=1000;          % wo=1000 U/s 
  vu2=0;            % iu2=0 mA
  vo2=15*1e4;       % io2=15*1e4 mA 
  vu3=-0.4;         % phiu=-20° in rad
  vo3=0.4;           % phio=+20° in rad

% ########################################################

% Eingabe des einzustellenden Winkels
%prompt='Welcher Winkel soll eingestellt werden ?';
%winkelein = input(prompt);
phi = 20*pi/180; 

  vu4=phi-0.5e-2*pi/180;
  vo4=phi+0.5e-2*pi/180;
  
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
% plot (t,y(:,2),'r','linewidth',2) 
xlabel('t / s')
ylabel('u_e / V') %',   M_L / Nm'
title('Gleichstrommotor: Motorspannung,') % Lastmoment
% plot (t,y(:,3),'linewidth',2);
% axis([0 te vu vo])
% grid on
% xlabel('t / s')
% ylabel('\omega / U/s')
% title('Gleichstrommotor: Drehzahl')

subplot(3,1,2)
% y(:,3)=(y(:,3)/(2*pi))*60; % rad/s  ->  U/min
% plot (t,y(:,3),'linewidth',2);
% axis([0 te vu vo])
% grid on
% xlabel('t / s')
% ylabel('\omega / U/s')
% title('Gleichstrommotor: Drehzahl')
plot(t,y(:,5),t,phi,'linewidth',2,'linewidth',2);
axis([0 te vu3 vo3])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')

subplot(3,1,3)
plot(t,y(:,5),t,phi,t,(phi-1e-3*pi/180),t,(phi+1e-3*pi/180),'linewidth',...
    2,'linewidth',2,'linewidth',2,'linewidth',2);
axis([0 te vu4 vo4])
grid on
xlabel('t / s')
ylabel('Phi / rad')
title('Gleichstrommotor: Winkel')
%subplot(3,1,3)
% y(:,4)=y(:,4)*1000; % rad/s  ->  U/min
% plot (t,y(:,4),'linewidth',2);
% axis([0 te vu2 vo2])
% grid on
% xlabel('t / s')
% ylabel('i_A / mA')
% title('Gleichstrommotor: Motorstrom')


% Plot der Winkel�nderung
%
% plot(t,y(:,5),'linewidth',2);
% axis([0 te vu3 vo3])
% grid on
% xlabel('t / s')
% ylabel('Phi / rad')
% title('Gleichstrommotor: Winkel')

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





