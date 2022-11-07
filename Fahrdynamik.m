%%Fahrdynamik Parameter

clc;
clear;

m   = 1359.8;       %Masse Fahrzeugs                     kg
Iz  = 1992.54;      %Trägheit                            kg*m^2
% a   = 1.06282;    %Abstand Vorderachse zum Schwerpunkt m
% b   = 1.48518;    %Abstand Hinterachse zum Schwerpunkt m
a   = 1.25;         %Abstand Vorderachse zum Schwerpunkt m
b   = 1.35;         %Abstand Hinterachse zum Schwerpunkt m
c1  = 52480;        %Reifensteifigkeit Vorderrad         N/rad
c2  = 88416;        %Reifensteifigkeit Hinterrad         N/rad

av=0.8;
ah=0.8;             % Hintenachse zu Autovorderseite  m

ab=1.788;           % Auto Bereite m

c_w = 0.34;         %Luftwiderstandbeiwert           
roh = 1.225;        %Luftdichte bei 25 °C              kg/m^3
A_f = 1.6 + 0.00056*(m-765);        %Querfläche        m^2
f_r  = 0.015;       %Rollwiderstandbeiwert
g   = 9.81;         %Erdebeschleunigung


T0=0.1;             %Abtastzeit von 0,1 Sekunde
 
aa=0;               %Anfangsposition des Fahrzeugs in der x-Richtung
bb=0.5;             %Anfangsposition des Fahrzeugs in der y-Richtung
cc=0;               %Anfangsorientierung des Fahrzeugs 

%% Zustandsraummodell
% a11=-(c1+c2)/(m*Vx

