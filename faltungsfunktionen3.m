%%
clear;close all;clc;

xmin = -pi/2;
xmax = pi/2;
x = linspace(xmin,xmax,1000);
c = 1;
e = 1;
b = pi/2;
pb = 0;
ps1 = b/2;
g = [];
r = [];
s1 = [];

%% 

for i = x
    r(end+1) = frect(i,b,pb);
    s1(end+1) = frect(i,b,ps1);
end
%r = 1-r;
figure();plot(x,r,x,s1);
axis([xmin xmax 0 2])
set(gca,'XTick',[-pi/2:pi/4:pi/2])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})

%%
f = conv(r,s1);
f = f./max(f);
x2 = linspace(2*min(x),2*max(x),size(f,2));
figure();plot(x2,1-f,x,s1);
axis([xmin xmax 0 2*max(f)])
set(gca,'XTick',[-pi/2:pi/4:pi/2])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})

%%
for i = x2
	g(end+1) = gekern(i,e,c);
end
g = g./max(g);

gf = conv(g,1-f);
gf = gf/max(gf);
x3 = linspace(4*min(x),4*max(x),size(gf,2));
figure();plot(x3,gf,x,s1);
axis([xmin xmax 0 2*max(gf)])
set(gca,'XTick',[-pi/2:pi/4:pi/2])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})


%%
figure();plot(x3,gf,x2,1-f);
axis([xmin xmax 0 2*max(gf)])
set(gca,'XTick',[-pi/2:pi/4:pi/2])
set(gca,'XTickLabel',{'-pi/2','-pi/4','0','pi/4','pi/2'})