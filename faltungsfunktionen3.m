%%
clear;close all;clc;

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

%% Sensor 1 und 2 sowie Blende
for i = x
    r(end+1) = frect(i,b,pb);
    s1(end+1) = frect(i,b,ps1);
    s2(end+1) = frect(i,b,-ps1);
end
r = 1-r;
s1 = 1-s1;
s2 = 1-s2;
fig1 = figure(1);plot(x,1-r,x,s1); hold on;
h1=fill(x, (r),'k','Edgecolor', 'none'); 
set(h1,'FaceAlpha',[0.3]) 
axis([showmin showmax 0 2])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Sensor 1 und Blende');

fig2 = figure(2);plot(x,1-r,x,s2); hold on;
h2=fill(x, (r),'k','Edgecolor', 'none'); 
set(h2,'FaceAlpha',[0.3]) 
axis([showmin showmax 0 2])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Sensor 2 und Blende');

fig3 = figure(3);plot(x,1-r,x,s1); hold on;
title ('Gesammter Wertebereich für Sensor 1')

%% Signal 1
f1 = conv(r,s1);
f1 = f1./max(f1);
x21 = linspace(2*min(x),2*max(x),size(f1,2));
fig4 = figure();plot(x21,f1,x,s1);
axis([showmin showmax 0 2*max(f1)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 1 und Sensor 1');

%% Signal 2
f2 = conv(r,s2);
f2 = f2./max(f2);
x22 = linspace(2*min(x),2*max(x),size(f2,2));
fig5 = figure();plot(x22,f2,x,s2);
axis([showmin showmax 0 2*max(f2)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 2 und Sensor 2');

%% Glätten von Signal 1 und 2
for i = x21
	g(end+1) = gekern(i,e,c);
end
g = g./max(g);

gf1 = conv(g,f1);
gf1 = gf1./max(gf1);
gf2 = conv(g,f2);
gf2 = gf2./max(gf2);

%% Signal 1 mit Sensor 1
x3 = linspace(4*min(x),4*max(x),size(gf1,2));
fig6 = figure();plot(x3,gf1,x,s1);
axis([showmin showmax 0 2*max(gf1)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 1 mit Sensor 1');

%% Signal 2 mit Sensor 2
fig7 = figure();plot(x3,gf2,x,s2);
axis([showmin showmax 0 2*max(gf2)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 2 mit Sensor 2');

%% Signal 1 mit geglättetem Signal 1
fig8 = figure();plot(x3,gf1,x21,f1);
axis([showmin showmax 0 2*max(gf1)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 1 mit geglaettetem Signal 1')

%% Signal 2 mit geglättetem Signal 2
fig9 = figure();plot(x3,gf2,x22,f2);
axis([showmin showmax 0 2*max(gf2)])
set(gca,'XTick',[showmin:showmax/2:showmax])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})
title('Signal 2 mit geglaettetem Signal 2')

%% Signal Gesammt
f = f1-f2;
f = f./max(f);

gf = gf1-gf2;
gf = gf./max(gf);

fig10 = figure();plot(x3,gf,x21,f);
axis([showmin/2 showmax/2 2*min(gf) 2*max(gf)])
set(gca,'XTick',[showmin/2:showmax/4:showmax/2])
set(gca,'XTickLabel',{'-pi/4','-pi/8','0','pi/8','pi/4'})
title('Gesammt Signal')

%%
z = 0;
for fig = [fig1,fig2,fig3,fig4,fig5,fig6,fig7,fig8,fig9,fig10]
    z = z + 1;
    saveas(fig,['/home/kizzm/Dokumente/Studium/Master_Photonik/Repos/syt_ss13/Plots/figure_',num2str(z),'.jpg']);
end    