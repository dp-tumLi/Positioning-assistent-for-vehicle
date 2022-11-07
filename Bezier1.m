function [xs,ys,Kappa] = Bezier1(x0,y0,dy0,xf,yf,dyf,kappa_M)

fun=@(x) Beziercontrollpoint(x0,y0,dy0,xf,yf,x,kappa_M);


A=[];
b=[];
Aeq=[];
beq=[];

    
lb=[x0+0.0001 -10 x0 -10 x0 -10];
ub=[xf-0.0001 10 xf 10 xf 10];

nonlcon=@(x) UngleichKappa1(x0,y0,dy0,xf,yf,x,kappa_M);

% nonlcon=@nonlinear;

% options= optimoptions('fmincon','Algorithm','sqp','Display','iter','MaxIterations',1000,...
% 'ConstraintTolerance',1e-2);

% [x,fval,exitflag,output]=fmincon(fun,x,A,b,Aeq,beq,lb,ub,nonlcon,options);

% genetischer Algorithmus
options= optimoptions('gamultiobj','ConstraintTolerance',1e-3,'TolFun',1e-4);

% [x,fval,exitflag,output]=ga(fun,3,A,b,Aeq,beq,lb,ub,nonlcon,options);
[x,fval,exitflag,output]=gamultiobj(fun,6,A,b,Aeq,beq,lb,ub,nonlcon,options);


%%

while exitflag
    
P0=[x0 y0];    

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

x1=x(1);
y1=x(2);
x2=x(3);
y2=x(4);
x3=x(5);
y3=x(6);
P1=[x1 y1]; 
P2stern=[x2 y2];
% P3=[x3 yf];
P3=[x3 y3];
P4=[xf yf];


xs=zeros(101,1);
ys=zeros(101,1);
dPath=zeros(101,2);
d2Path=zeros(101,2);
Kappa=zeros(101,1);

P_t=zeros(1,2);
dP_t=zeros(1,2);
d2P_t=zeros(1,2);
k=zeros(1);

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


xq=linspace(xs(1),xs(101),50);
vq1=interp1(xs,ys,xq);
vq2=interp1(xs,Kappa,xq);

xs=xq;
ys=vq1;
Kappa=vq2;

break
end

