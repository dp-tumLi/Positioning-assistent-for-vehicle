function [c, ceq]=UngleichKappa1(x0,y0,dy0,xf,yf,x,kappa_M)
k_max=kappa_M;

% Zur Überprüfung der statischen Punkte
% P0=[0 0];
% P1=[5 0.5];
% P2=[4 3.5]; % Kontrollpunkt zum Wendepunkt
% P3=[9 2.5];
% P4=[13 2.5];

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

%% für 4 Parameter
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

%% für 6  parameter
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

for n=1:101
    
t=(n-1)/100;
% P_t=[0 0];    
P_t=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;

dP_t=-4*P0*(1-t)^3+(-12*P1*(1-t)^2*t+4*P1*(1-t)^3)+(-12*P2*(1-t)*t^2+...
    6*P2*(1-t)^2*2*t)+(-4*P3*t^3+4*P3*(1-t)*3*t^2)+4*P4*t^3;

d2P_t=12*P0*(1-t)^2+(24*P1*(1-t)*t-12*P1*(1-t)^2)-12*P1*(1-t)^2+...
    (12*P2*t^2-24*P2*(1-t)*t)+(-12*P2*(1-t)*2*t+12*P2*(1-t)^2)+...
    (-12*P3*t^2-12*P3*t^2+24*P3*(1-t)*t)+12*P4*t^2;

k=(dP_t(1)*d2P_t(2)-dP_t(2)*d2P_t(1))/((dP_t(1)^2+dP_t(2)^2)^(1.5));

Path(n,:)=P_t;
dPath(n)=dP_t(2)/dP_t(1);
d2Path(n,:)=d2P_t;
Kappa(n)=k;
% plot(P_t(1),P_t(2),'r');
end
%% Die Ausgabe der nichtlineare Restriktion Cg und Cu
c(1)=max(Kappa)-k_max;
c(2)=-min(Kappa)+k_max;

ceq(1)=dPath(101);
ceq(2)=dPath(1)-dy0;


