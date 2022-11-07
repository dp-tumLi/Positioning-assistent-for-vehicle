%% Bachelorarbeit von Li, Yu am 31.10.2021
% Dieses Skript beeinhaltet die Zielfunktionen aller Varianten
% 2DOF, und Mehrvariable 3,4,6 DOF
% 
clc
clear 
close all
% Parametrierung der Randbedingung 
x0=0;
y0=0;
dy0=0;
xf=12.75;
yf=2.5;
dyf=0;
kappa_M=0.174;
%% 2DOF 
% Parametrierung der Kontrollpunkte

P0=[x0 y0];
P1=[(xf-x0)/3+x0  dy0*(xf-x0)/3+y0];
P3=[xf-(xf-x0)/3  yf]; 
P4=[xf yf];

% Funktionhandle aus Bezier4Funktion, die sich für 2DOF geeignet 
fun=@(P2) Bezier4Funktion(P0,P1,P2,P3,P4,kappa_M);

A=[];
b=[];
Aeq=[];
beq=[];
% Unterscheidung der Obergrenze und Untengrenze

if y0<yf
    lb=[x0 y0];
    ub=[xf yf+0.5];
else 
    lb=[x0 yf];
    ub=[xf y0+0.5];
end

% keine nichtlineare Restriktion aufgestellt
nonlcon=[];
% genetischer Algorithmus
options= optimoptions('ga','ConstraintTolerance',1e-2);

[P2stern,fval,exitflag,output]=ga(fun,2,A,b,Aeq,beq,lb,ub,nonlcon,options);

%% Mehr Variablen Berechnung
% 6 DOF, 4 DOF und 3 DOF kann je nach Untersuchungsbedarf kommentiert
% werden.
%--------------------------------------------------------------------
% fun=@(x) Beziercontrollpoint(x0,y0,dy0,xf,yf,x,kappa_M);
% 
% 
% A=[];
% b=[];
% Aeq=[];
% beq=[];
%
% % die Unter- und Obergrenze für 6DOF
% lb=[x0+0.0001 -10 x0 -10 x0 -10];
% ub=[xf-0.0001 10 xf 10 xf 10];
%
% % die Unter- und Obergrenze für 3DOF
% lb=[x0 x0 x0];
% ub=[xf y0 xf];
%
% % die Unter- und Obergrenze für 4 DOF
% lb=[x0 x0 x0 x0];
% ub=[xf y0 xf xf];
%
% % Ungleichheitrestriktion
% nonlcon=@(x) UngleichKappa1(x0,y0,dy0,xf,yf,x,kappa_M);
% 
% % genetischer Algorithmus
%  options= optimoptions('gamultiobj','ConstraintTolerance',1e-4,'TolFun',1e-8);
% 
%  % hier die 2. Stelle der gamultiobj-Funktion mit Anzahl der Variablen
%  % korrigieren 3DOF für 3, 4DOF für 4 und 6DOF für 6
%
%
% [x,fval,exitflag,output]=gamultiobj(fun,6,A,b,Aeq,beq,lb,ub,nonlcon,options);
% -------------------------------------------------------------------------
%% Die Koordinateninformation wird geliefert 

while exitflag
%% die Einsetzung von 2DOF
xs=zeros(101,1);
ys=zeros(101,1);
dPath=zeros(101,2);
d2Path=zeros(101,2);
Kappa=zeros(101,1);

P_t=zeros(1,2);
dP_t=zeros(1,2);
d2P_t=zeros(1,2);
k=zeros(1);
%% die Einsetzung von 3 DOF
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

%% die Einsetzung von 4DOF
% P0=[x0 y0];    
% x1=x(1);
% x2=x(2);
% y2=x(3);
% x3=x(4);
% y1=dy0*(x1-x0)+y0;
% 
% P1=[x1 y1]; 
% P2stern=[x2 y2];
% P3=[x3 yf];
% P4=[xf yf];

%% die Einsetzung von 6DOF
% P0=[x0 y0]; 
% x1=x(1);
% y1=x(2);
% x2=x(3);
% y2=x(4);
% x3=x(5);
% y3=x(6);
% P1=[x1 y1]; 
% P2stern=[x2 y2];
% P3=[x3 y3];
% P4=[xf yf];
%% Bezier Kurve und deren 1. und 2. Ableitung berechnen
for n=1:1:101
    
t=(n-1)/100;
% P_t=[0 0];    
P_t=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2stern*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;
% P_t_y=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2stern*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;

dP_t=-4*P0*(1-t)^3+(-12*P1*(1-t)^2*t+4*P1*(1-t)^3)+(-12*P2stern*(1-t)*t^2+...
    6*P2stern*(1-t)^2*2*t)+(-4*P3*t^3+4*P3*(1-t)*3*t^2)+4*P4*t^3;

d2P_t=12*P0*(1-t)^2+(24*P1*(1-t)*t-12*P1*(1-t)^2)-12*P1*(1-t)^2+...
    (12*P2stern*t^2-24*P2stern*(1-t)*t)+(-12*P2stern*(1-t)*2*t+12*P2stern*(1-t)^2)+...
    (-12*P3*t^2-12*P3*t^2+24*P3*(1-t)*t)+12*P4*t^2;

k=(dP_t(1)*d2P_t(2)-dP_t(2)*d2P_t(1))/((dP_t(1)^2+dP_t(2)^2)^(1.5));

xs(n,:)=P_t(1);
ys(n,:)=P_t(2);
dPath(n,:)=dP_t;
% d2Path(n,:)=d2P_t;
Kappa(n)=k;

end
% Um die keine Monotonie zu vermeiden, wird nochmal mit weniger Punkten die
% lineare Interpolation durchgeführt, soweit die Anzahl der Abtastpunkte auch
% reduziert wird
xq=linspace(xs(1),xs(101),50);
vq1=interp1(xs,ys,xq);
vq2=interp1(xs,Kappa,xq);

xs=xq;
ys=vq1;
Kappa=vq2;
break
end

