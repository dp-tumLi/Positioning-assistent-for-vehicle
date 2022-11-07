function ZweiDFahranimation(x_st, y_st,x_s, y_s, psi_s,x_soll,y_soll, delta_r, delta_l)
%% Fahrkontur
a   = 1.35;      %Abstand Vorderachse zum Schwerpunkt m   
b   = 1.35;      %Abstand Hinterachse zum Schwerpunkt m

ab=1.788;        % Auto Bereite m
av=0.95;          % Voderachse zum Autovorderseite
bh=0.9;          % Hintenachse zum Autohintenseite

xHAM=x_s-cos(psi_s)*(b);             % Hintenachsenmittelpunkt
yHAM=y_s-sin(psi_s)*(b);
xHM=x_s-cos(psi_s)*(b+bh);
yHM=y_s-sin(psi_s)*(b+bh);

xVAM=x_s+cos(psi_s)*(a);             % Vorderachsenmittelpunkt
yVAM=y_s+sin(psi_s)*(a);
xVM=x_s+cos(psi_s)*(a+av);
yVM=y_s+sin(psi_s)*(a+av);

xHL=xHM-sin(psi_s)*ab/2;         % Hinten Links
yHL=yHM+cos(psi_s)*ab/2;

xHR=xHM+sin(psi_s)*ab/2;         % Hinten Rechts
yHR=yHM-cos(psi_s)*ab/2;

xVL=xVM-sin(psi_s)*ab/2;         % Vorne Links
yVL=yVM+cos(psi_s)*ab/2;

xVR=xVM+sin(psi_s)*ab/2;         % Vorne Rechts
yVR=yVM-cos(psi_s)*ab/2;


xF=[xHR xVR xVL xHL xHR];
yF=[yHR yVR yVL yHL yHR];

%%
% Primärspule auf dem Boden
xSP=[12.9  13.5 13.5  12.9  12.9];
ySP=[2.2  2.2  2.8  2.8  2.2];
plot(xSP,ySP,'g');
hold on
%% Planung der Refenzpunkten
% RFID-Tags 
% Abstand der Punkte
d=0.1414;
% erste Reihe von E-Tags
n=linspace(1,17,17); % Anzahl einer Reihe von 17 oder 18
X1=zeros(35,2);
X1(2*n-1,1)=5;
X1(2*n,1)=5+d;
X1(2*n-1,2)=(2*n-1)*d;
X1(2*n,2)=2*n*d;     % zwei Reihe versetzt
% zweite Reihe von E-Tags
X2=zeros(35,2);
X2(2*n-1,1)=10;
X2(2*n,1)=10+d;
X2(2*n-1,2)=(2*n-1)*d;
X2(2*n,2)=2*n*d;
for k=1:1:17
% Radius des Referenzobjekts
r=0.0325;
% erste Reihe der versetzten Referenzpunkten
rectangle('Position',[X1(2*k-1,1)-r,X1(2*k-1,2)-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'FaceColor',[0 .5 .5]);
rectangle('Position',[X1(2*k,1)-r,X1(2*k,2)-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'FaceColor',[0 .5 .5]);
% zweite Reihe der versetzten Referenzpunkten
rectangle('Position',[X2(2*k-1,1)-r,X2(2*k-1,2)-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'FaceColor',[0 .5 .5]);
rectangle('Position',[X2(2*k,1)-r,X2(2*k,2)-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'FaceColor',[0 .5 .5]);
% Endreferenzpunkt
rectangle('Position',[14-r,2.5-r,2*r,2*r],'Curvature',[1,1],'linewidth',1,'FaceColor',[0 .5 .5]);
% lässt sich statisch gehalten, nicht löschbar 
hold on
end
     
%% die primäre Spule
% mit der Maße von 60*60 cm
%% Plot 
set(gcf,'Position',[500 500 1000 400]);  % Plot Größe und Position aufs Windows Desktop
rectangle('Position',[0 0 15 5]);        % Szenegröße in Skalierung
axis([-2 16 1 4]);                       % Axis angeben
daspect([1 1 1]);                        % gleiche Skalierung von x-y-Achsen
 
plot(x_s,y_s,'ko');

% plot(x_soll,y_soll);
ylabel('$lateral_\mathrm{y}$ in m','Interpreter','latex');
xlabel('$longitudinal_\mathrm{x}$ in m','Interpreter','latex');
hold on


%% Transpondern aufs Fahrzeug (sekundärseitige Spule)

xDeHM=x_s+cos(psi_s)*(a-0.7-0.175);
yDeHM=y_s+sin(psi_s)*(a-0.7-0.175);

xDeVM=x_s+cos(psi_s)*(a-0.7+0.175);
yDeVM=y_s+sin(psi_s)*(a-0.7+0.175);

xDeHL=xDeHM-sin(psi_s)*0.175;         % Hinten Links
yDeHL=yDeHM+cos(psi_s)*0.175;

xDeHR=xDeHM+sin(psi_s)*0.175;         % Hinten Rechts
yDeHR=yDeHM-cos(psi_s)*0.175;

xDeVL=xDeVM-sin(psi_s)*0.175;         % Vorne Links
yDeVL=yDeVM+cos(psi_s)*0.175;

xDeVR=xDeVM+sin(psi_s)*0.175;         % Vorne Rechts
yDeVR=yDeVM-cos(psi_s)*0.175;

xAnt=[xDeHR xDeVR xDeVL xDeHL xDeHR];
yAnt=[yDeHR yDeVR yDeVL yDeHL yDeHR];


%% Positionierungsantenne aufs Fahrzeug
%  mit Maße von 20*20
xDeHM=x_s+cos(psi_s)*(a);
yDeHM=y_s+sin(psi_s)*(a);

xDeVM=x_s+cos(psi_s)*(a+0.2);
yDeVM=y_s+sin(psi_s)*(a+0.2);

xDeHL=xDeHM-sin(psi_s)*0.1;         % Hinten Links
yDeHL=yDeHM+cos(psi_s)*0.1;

xDeHR=xDeHM+sin(psi_s)*0.1;         % Hinten Rechts
yDeHR=yDeHM-cos(psi_s)*0.1;

xDeVL=xDeVM-sin(psi_s)*0.1;         % Vorne Links
yDeVL=yDeVM+cos(psi_s)*0.1;

xDeVR=xDeVM+sin(psi_s)*0.1;         % Vorne Rechts
yDeVR=yDeVM-cos(psi_s)*0.1;

xDetek=[xDeHR xDeVR xDeVL xDeHL xDeHR];
yDetek=[yDeHR yDeVR yDeVL yDeHL yDeHR];
%% Lenkwinkel der Reifen
% Transformation von Null bis Fahrzeugkoordinate
Hz1=[cos(psi_s) -sin(psi_s)   x_s;
     sin(psi_s)  cos(psi_s)   y_s;
     0           0            1  ;];
% translatorische Tranformation zu Reifen Vorne Links 
%-----------------------------------------------------------------------------------------
% homogene(translatorisch) Transformationsmatrix von Schwerpunkt auf
% Vornemittelpunkt
HtVL=[1          0              a ;
      0          1            ab/2-0.21;
      0          0              1 ;];
% homogene (rotatorisch) Transformationsmatrix von Vornemittelpunkt auf dem
% Bezugpunkt des vorderlinken Reifens
HzVL=[cos(delta_l) -sin(delta_l)     0;
      sin(delta_l)  cos(delta_l)     0;
      0             0                1;];
% relative Koordinate der Vier Eckpunkte des Reifens
XVL1=[-0.4  0   1];
XVL2=[0.4   0   1];
XVL3=[0.4  0.21  1];
XVL4=[-0.4 0.21  1];
XVL1=Hz1*HtVL*HzVL*transpose(XVL1);
XVL2=Hz1*HtVL*HzVL*transpose(XVL2);
XVL3=Hz1*HtVL*HzVL*transpose(XVL3);
XVL4=Hz1*HtVL*HzVL*transpose(XVL4);

x11=XVL1(1);
y11=XVL1(2);

x12=XVL2(1);
y12=XVL2(2);

x13=XVL3(1);
y13=XVL3(2);

x14=XVL4(1);
y14=XVL4(2);

xReifenVL=[x11 x12 x13 x14 x11];
yReifenVL=[y11 y12 y13 y14 y11];
% plot(xReifenVL,yReifenVL,'r');
%----------------------------------------------------------------------------
% vorne rechts
HtVR=[1          0              a ;
      0          1            -ab/2+0.21;
      0          0              1 ;];
HzVR=[cos(delta_r) -sin(delta_r)     0;
      sin(delta_r)  cos(delta_r)     0;
      0             0                1;];
XVR1=[-0.4  -0.21  1];
XVR2=[0.4   -0.21   1];
XVR3=[0.4   0     1];
XVR4=[-0.4  0     1];
XVR1=Hz1*HtVR*HzVR*transpose(XVR1);
XVR2=Hz1*HtVR*HzVR*transpose(XVR2);
XVR3=Hz1*HtVR*HzVR*transpose(XVR3);
XVR4=Hz1*HtVR*HzVR*transpose(XVR4); 

x21=XVR1(1);
y21=XVR1(2);

x22=XVR2(1);
y22=XVR2(2);

x23=XVR3(1);
y23=XVR3(2);

x24=XVR4(1);
y24=XVR4(2);

xReifenVR=[x21 x22 x23 x24 x21];
yReifenVR=[y21 y22 y23 y24 y21];
% plot(xReifenVR,yReifenVR,'r');
%----------------------------------------------------
% Hinten Links
HtHL=[1          0              -b ;
      0          1            ab/2-0.21;
      0          0              1 ;];
XHL1=[-0.4  0   1];
XHL2=[0.4   0   1];
XHL3=[0.4  0.21  1];
XHL4=[-0.4 0.21  1];
XHL1=Hz1*HtHL*transpose(XHL1);
XHL2=Hz1*HtHL*transpose(XHL2);
XHL3=Hz1*HtHL*transpose(XHL3);
XHL4=Hz1*HtHL*transpose(XHL4); 

x31=XHL1(1);
y31=XHL1(2);

x32=XHL2(1);
y32=XHL2(2);

x33=XHL3(1);
y33=XHL3(2);

x34=XHL4(1);
y34=XHL4(2);

xReifenHL=[x31 x32 x33 x34 x31];
yReifenHL=[y31 y32 y33 y34 y31];
% plot(xReifenHL,yReifenHL,'r');
%---------------------------------------------------------
% Hinten Rechts
HtHR=[1          0              -b ;
      0          1            -ab/2+0.21;
      0          0              1 ;];
XHR1=[-0.4  -0.21  1];
XHR2=[0.4   -0.21   1];
XHR3=[0.4   0     1];
XHR4=[-0.4  0     1];
XHR1=Hz1*HtHR*transpose(XHR1);
XHR2=Hz1*HtHR*transpose(XHR2);
XHR3=Hz1*HtHR*transpose(XHR3);
XHR4=Hz1*HtHR*transpose(XHR4); 

x41=XHR1(1);
y41=XHR1(2);

x42=XHR2(1);
y42=XHR2(2);

x43=XHR3(1);
y43=XHR3(2);

x44=XHR4(1);
y44=XHR4(2);

xReifenHR=[x41 x42 x43 x44 x41];
yReifenHR=[y41 y42 y43 y44 y41];

% plot(xReifenHR,yReifenHR,'r');
%% plot für dynamische Objekte


plot(xDetek,yDetek,'r',xAnt,yAnt,'b',xF,yF,'k',x_soll,y_soll,'c',...
    xReifenVL,yReifenVL,'r',xReifenVR,yReifenVR,'r',xReifenHL,yReifenHL,'r',xReifenHR,yReifenHR,'r');
% hold on;
hold off          % für dynamisch plotten
xlim([-1 16]);    
ylim([0  5]);
daspect([1 1 1]);



