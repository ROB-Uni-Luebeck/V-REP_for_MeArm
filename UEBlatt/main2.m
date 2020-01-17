clear all; close all; clc;

%% actual code
VREPconnect;

%%
% maximale Auslenkungen
% [-170, 170]
% [-120, 120]
% [-170, 170]
% [-120, 120]
% [-170, 170]
% [-120, 120]
% [-175, 175]

% starting at:
openGripper;
q = zeros(7,1); % current joint values
M_1 = LBRforKin(q,'LBR7_vrep');
VREPtransfer;
pause(1);

M_pickUp = [[eye(3)*rotx(90)*roty(90)*roty(90); 0 0 0] [0.48; 0.2; 0.45; 1]]
q = LBRinvKin(M_pickUp, [-1 -1 -1 90*pi/180], 'LBR7_vrep').*pi/180;
VREPtransfer;
pause(0.5)
VREPGetJoints;
q*180/pi
M_pickUp = [[eye(3)*rotx(90)*roty(90)*roty(90); 0 0 0] [0.48; 0.3; 0.45; 1]]
q = LBRinvKin(M_pickUp, [-1 -1 -1 90*pi/180], 'LBR7_vrep').*pi/180;
pause(5)
VREPtransfer;
pause(1)
closeGripper;
pause(10);
q = zeros(7,1);
VREPtransfer;
pause(5)
q = [0 0 0 90 0 0 0].*pi/180;

VREPtransfer;

pause(2)
q = [0 0 0 90 0 0 90].*pi/180;

VREPtransfer;
pause(2)
openGripper;
pause(10);
q = zeros(7,1);
VREPtransfer;
VREPdisconnect; % trennt die Verbindung -> nur einmal am Ende aufrufen
%%  0.0000   48.3844    0.0000  113.2619 -180.0000  115.1225  -90.0000

% q0 = zeros(7,1);
% q1 = [30 45 -35 -160 90 20 10].*pi/180;
% 0.5 0.3 0.3