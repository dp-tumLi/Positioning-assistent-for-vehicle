function [f0]=Bezier4Funktion(P0,P1,P2,P3,P4,kappa_M)
k_max=kappa_M;
% P0=[0 0];
% P1=[5 0.5];
% P2=[4 3.5]; % Kontrollpunkt zum Wendepunkt
% P3=[9 2.5];
% P4=[13 2.5];
% P3=[x3 2.5];
% P=[P0;P1;P2;P3;P4];
Path=zeros(101,2);
dPath=zeros(101,2);
d2Path=zeros(101,2);
Kappa=zeros(101,1);

P_t=zeros(1,2);
dP_t=zeros(1,2);
d2P_t=zeros(1,2);
k=zeros(1);

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
end
%% altes Optimierungsziel
% [M,I]=max(Kappa);
% [N,J]=min(Kappa);
% f0=1000*(M^2+N^2)+I+J;

[M,I]=max(abs(Kappa));
% f0=max(Kappa)-min(Kappa)
f0=(max(abs(Kappa))-k_max)^2+I;



