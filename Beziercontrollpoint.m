function [f0]=Beziercontrollpoint(x0,y0,dy0,xf,yf,x,kappa_M)
k_max=kappa_M;

P0=[x0 y0];
%% rechnen für 3 Parameter
% Zur Nutzung darf den Block für 3DOF kommentieren
% syms x1
% x2=x(1);
% y2=x(2);
% x3=x(3);
% eqns=[dy0*(x1-x0)+y0==(yf-y2)/(x3-x2)*(x1-x2)+y2];
% 
% S=solve(eqns,x1);
% S=double(vpa(S));
% x1=S;
% y1=dy0*(x1-x0)+y0;
%
% P1=[x1 y1]; 
% P2=[x2 y2];
% P3=[x3 yf];
% P4=[xf yf];

%% rechnen für 4 Parameter
% Zur Nutzung darf den Block 4DOF kommentieren
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

%% rechnen für 6  parameter
% Zur Nutzung darf den Block 6D0F kommentieren
x1=x(1);
y1=x(2);
x2=x(3);
y2=x(4);
x3=x(5);
y3=x(6);

P1=[x1 y1]; 
P2=[x2 y2];
% P3=[x3 yf];
P3=[x3 y3];
P4=[xf yf];

%%
% P=[P0;P1;P2;P3;P4];
Path=zeros(101,2);
dPath=zeros(101,2);
d2Path=zeros(101,2);
Kappa=zeros(101,1);

P_t=zeros(1,2);
dP_t=zeros(1,2);
d2P_t=zeros(1,2);
k=zeros(1);
yakku=0;
for n=1:1001
    
t=(n-1)/1000;
% P_t=[0 0];    
P_t=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;

dP_t=-4*P0*(1-t)^3+(-12*P1*(1-t)^2*t+4*P1*(1-t)^3)+(-12*P2*(1-t)*t^2+...
    6*P2*(1-t)^2*2*t)+(-4*P3*t^3+4*P3*(1-t)*3*t^2)+4*P4*t^3;

d2P_t=12*P0*(1-t)^2+(24*P1*(1-t)*t-12*P1*(1-t)^2)-12*P1*(1-t)^2+...
    (12*P2*t^2-24*P2*(1-t)*t)+(-12*P2*(1-t)*2*t+12*P2*(1-t)^2)+...
    (-12*P3*t^2-12*P3*t^2+24*P3*(1-t)*t)+12*P4*t^2;

k=(dP_t(1)*d2P_t(2)-dP_t(2)*d2P_t(1))/((dP_t(1)^2+dP_t(2)^2)^(1.5));

Path(n,:)=P_t;
dPath(n,:)=dP_t;
d2Path(n,:)=d2P_t;
Kappa(n)=k;
% plot(P_t(1),P_t(2),'r');
yakku=abs(P_t(1)-2.5)+yakku;
end
% f0=x(1)^2+4*x(3)^2-x(2)^2;
%%Ausgabe der Objektfunktion
%% mit 3 variablen 3DOF
% f0(1)=x(1)^2;
% f0(2)=-(x(2)^2);
% f0(3)=x(3)^2;

%% mit 4 Variablen 4DOF
% f0(1)=x1^2;
% f0(2)=x2^2;
% f0(3)=100*abs(y2-2.5)^2;
% % f0(3)=-x(3);
% f0(4)=x^2;
% [M,I]=max(Kappa);
% [N,J]=min(Kappa);
% f0(5)=I;
% f0(6)=-M*1000;
% f0(7)=J;
% f0(8)=N*1000;
%% mit 6 Variablen 6DOF
f0(1)=100*abs(y2-2.5);
f0(2)=yakku;

%% sonstige mögliche Objekfunktion zum Testen
% [M,I]=max(abs(Kappa));
% f0(5)=I;
% f0(6)=-M;

% [M,I]=max(Kappa);
% [N,J]=min(Kappa);
% f0(1)=I;
% f0(2)=-M*1000;
% f0(3)=-x(4);
% f0(4)=J;
% % % f0(4)=N*1000;
% f0(5)=N-M;

% f0(2)=-max(Kappa)*100;
% f0(3)=min(Kappa)*100;

% [M,I]=max(abs(Kappa));
% % f0=max(Kappa)-min(Kappa)
% f0(1)=(max(abs(Kappa))-k_max)^2;
% f0(2)=I;


