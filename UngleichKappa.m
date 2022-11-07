function [c, ceq]=UngleichKappa(P0,P1,P2,P3,P4,kappa_M)
k_max=kappa_M;
% P0=[0 0];
% P1=[5 0.5];
% P2=[4 3.5]; % Kontrollpunkt zum Wendepunkt
% P3=[9 2.5];
% P4=[13 2.5];

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

c(1)=max(abs(Kappa))-k_max;
% c(2)=(-min(Kappa)+k_max);
% c(2)=min(Kappa)+k_max;
ceq=[];
dp0x=4*(P1(1)-P0(1));
dp0y=4*(P1(2)-P0(2));
d2p0x=12*(P0(1)-2*P1(1)+P2(1));
d2p0y=12*(P0(2)-2*P1(2)+P2(2));



% ceq(1)=(dp0x*d2p0y-dp0y*d2p0x)/(dp0x^2+dp0y^2)^(3/2);
% ceq(1)=Kappa(1);

% k0=0;
% [~,Index]=min(abs(Kappa-k0));
% [~,Index0]=min(abs(Kappa-k_max));
% [~,Index1]=min(abs(Kappa+k_max));
% if Index0-Index1<0
%     
% c(3)=Index0-Index;
% c(4)=Index-Index1;
% 
% else
% c(3)=Index1-Index;
% c(4)=Index-Index0;
% end

