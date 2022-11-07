function [xs,ys,Kappa] = Bezier(x0,y0,dy0,xf,yf,dyf,kappa_M)

% coder.extrinsic('Bezier4Funktion');
% coder.extrinsic('ga');

P0=[x0 y0];
P1=[(xf-x0)/3+x0  dy0*(xf-x0)/3+y0];
P3=[xf-(xf-x0)/3  yf];
P4=[xf yf];

% P2=[(P1(1)+P3(1))/2 (P1(2)+P3(2))/2];

fun=@(P2) Bezier4Funktion(P0,P1,P2,P3,P4,kappa_M);


A=[];
b=[];
Aeq=[];
beq=[];
if y0<yf
    lb=[x0 y0];
    ub=[xf yf+0.5];
else 
    lb=[x0 yf];
    ub=[xf y0+0.5];
end
% lb=[];
% ub=[];
% nonlcon=[];
nonlcon=@(P2) UngleichKappa(P0,P1,P2,P3,P4,kappa_M);

% nonlcon=@nonlinear;

% options= optimoptions('fmincon','Algorithm','sqp','Display','iter','MaxIterations',1000,...
% 'ConstraintTolerance',1e-2);

% [P2stern,fval,exitflag,output]=fmincon(fun,P2,A,b,Aeq,beq,lb,ub,nonlcon,options);

% ga algorithmus
options= optimoptions('ga','ConstraintTolerance',1e-6);

[P2stern,fval,exitflag,output]=ga(fun,2,A,b,Aeq,beq,lb,ub,nonlcon,options);

%%

xs=zeros(101,1);
ys=zeros(101,1);
Kappa=zeros(101,1);

while exitflag


dPath=zeros(101,2);
d2Path=zeros(101,2);

P_t=zeros(1,2);
dP_t=zeros(1,2);
d2P_t=zeros(1,2);
k=zeros(1);

for n=1:101
    
t=(n-1)/100;
% P_t=[0 0];    
P_t=P0*(1-t)^4+4*P1*(1-t)^3*t+6*P2stern*(1-t)^2*t^2+4*P3*(1-t)*t^3+P4*t^4;


dP_t=-4*P0*(1-t)^3+(-12*P1*(1-t)^2*t+4*P1*(1-t)^3)+(-12*P2stern*(1-t)*t^2+...
    6*P2stern*(1-t)^2*2*t)+(-4*P3*t^3+4*P3*(1-t)*3*t^2)+4*P4*t^3;

d2P_t=12*P0*(1-t)^2+(24*P1*(1-t)*t-12*P1*(1-t)^2)-12*P1*(1-t)^2+...
    (12*P2stern*t^2-24*P2stern*(1-t)*t)+(-12*P2stern*(1-t)*2*t+12*P2stern*(1-t)^2)+...
    (-12*P3*t^2-12*P3*t^2+24*P3*(1-t)*t)+12*P4*t^2;

k=(dP_t(1)*d2P_t(2)-dP_t(2)*d2P_t(1))/((dP_t(1)^2+dP_t(2)^2)^(1.5));

xs(n,:)=P_t(1);
ys(n,:)=P_t(2);
% dPath(n,:)=dP_t;
% d2Path(n,:)=d2P_t;
Kappa(n)=k;

end
% xs=Path(:,1);
% xs=xs.';
% ys=ys.';
break
end