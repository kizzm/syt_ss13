%%
clear;close all;clc;

x = linspace(-pi,pi,1000);
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
    g(end+1) = gekern(i,e,c);
    r(end+1) = frect(i,b,pb);
end
%r = 1-r;

%%
figure();plot(x,g);
axis([-pi pi 0 3*max(g)]);
figure();plot(x,r);
axis([-pi pi 0 3]);
%%
grect=conv(g,r);
grect=grect./max(grect);
x2 = linspace(min(x),max(x),size(grect,2));
figure();plot(x2,1-grect);
axis([-pi pi 0 3]);

%%
for i = x2
	s1(end+1) = frect(i,b,ps1);
end

%%
figure();plot(x2,s1); hold on
axis([-pi pi 0 3*max(s1)]);

%%
gs1=conv(grect,s1);
gs1=gs1./max(gs1);
x3 = linspace(min(x),max(x),size(gs1,2));
plot(x3,gs1);
axis([-pi pi 0 3]);