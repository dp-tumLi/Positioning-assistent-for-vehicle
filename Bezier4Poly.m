%% Bacheloarbeit von Li, Yu am 31.10.2021
% Skript zur grafischen Darstellung der Bézier Kurve mit variierten
% Freiheitsgraden
clc
clear 
close all

x0=0;
y0=0;
dy0=0;
xf=12.75;
yf=2.5;
dyf=0;
kappa_M=0.174;

%% die Lösungseinsetzung für 2DOF 
P0=[x0 y0];
P1=[(xf-x0)/3+x0  dy0*(xf-x0)/3+y0];
P3=[xf-(xf-x0)/3  yf];
P4=[xf yf];
% Lösungen hier eingeben
P2=[7.435568564163727,4.190502512335749]; % Kontrollpunkt zum Wendepunkt

%% Die Lösungseinsetzung für 3DOF
% P0=[x0 y0];
% syms x1
% x=[];
% x2=x(1);
% y2=x(2);
% x3=x(3);
% eqns=[dy0*(x1-x0)+y0==(yf-y2)/(x3-x2)*(x1-x2)+y2];
% 
% S=solve(eqns,x1);
% S=double(vpa(S));
% x1=S;
% y1=dy0*(x1-x0)+y0;
% P1=[x1 y1]; 
% P2=[x2 y2];
% P3=[x3 yf];
% P4=[xf yf];

%% Die Lösungseinsetzung für 4DOF
% P0=[x0 y0];
% x=[];
% x1=x(1);
% x2=x(2);
% y2=x(3);
% x3=x(4);
% y1=dy0*(x1-x0)+y0;
% 
% P1=[x1 y1]; 
% P2=[x2 y2];
% P3=[x3 yf];
% P4=[xf yf];
% P=[P0;P1;P2;P3;P4];

%% Die Lösungseinsetzung für 6DOF
% P0=[x0 y0];
% x=[];
% x1=x(1);
% y1=x(2);
% x2=x(3);
% y2=x(4);
% x3=x(5);
% y3=x(6);
% 
% P1=[x1 y1]; 
% P2=[x2 y2];
% % P3=[x3 yf];
% P3=[x3 y3];
% P4=[xf yf];
%% Beginn des Plots
Path=[];
dPath=[];
d2Path=[];
Kappa=[];

for t=0:0.001:1
% P_t=[0 0];    
P_t=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;

dP_t=-4*P0*(1-t)^3+(-12*P1*(1-t)^2*t+4*P1*(1-t)^3)+(-12*P2*(1-t)*t^2+...
    6*P2*(1-t)^2*2*t)+(-4*P3*t^3+4*P3*(1-t)*3*t^2)+4*P4*t^3;

d2P_t=12*P0*(1-t)^2+(24*P1*(1-t)*t-12*P1*(1-t)^2)-12*P1*(1-t)^2+...
    (12*P2*t^2-24*P2*(1-t)*t)+(-12*P2*(1-t)*2*t+12*P2*(1-t)^2)+...
    (-12*P3*t^2-12*P3*t^2+24*P3*(1-t)*t)+12*P4*t^2;

k=(dP_t(1)*d2P_t(2)-dP_t(2)*d2P_t(1))/((dP_t(1)^2+dP_t(2)^2)^(1.5));

Path(end+1,:)=P_t;
dPath(end+1)=dP_t(2)/dP_t(1);
% dPath(end+1,:)=dP_t;
d2Path(end+1,:)=d2P_t;
Kappa(end+1)=k;
% plot(P_t(1),P_t(2),'r');
end

k0=0;
[~,Index]=min(abs(Kappa-k0));

kM=max(abs(Kappa));
subplot(3,1,1);
plot(Path(:,1),Path(:,2),'r');
hold on
plot([P0(1) P1(1) P2(1) P3(1) P4(1)],[P0(2) P1(2) P2(2) P3(2) P4(2)],'bo');
grid on
title('Bahnplanungstrecke');
xlabel('xs:m');
ylabel('ys:m');
% xlim([-0.5 13]);
% ylim([-0.5 4.5]);
axis equal
subplot(3,1,2);
plot(Path(:,1),Kappa,'k');
title('Krümmugnsverlauf');
xlabel('xs:m');
ylabel('Krümmung:1/m');
subplot(3,1,3);
plot(Path(:,1),dPath,'b');
title('Orientierung');
xlabel('xs:m');
ylabel('Orientierung in Radius');


