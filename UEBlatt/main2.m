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

% go to certain pos
M_pickUp = [[eye(3)*rotx(90)*roty(90)*roty(90); 0 0 0] [0.48; 0.2; 0.45; 1]]
%q = [170 45 -35 -110 90 20 174].*pi/180;
%M_pickUp = LBRforKin(q,'LBR7_vrep')
%VREPtransfer;
q = LBRinvKin(M_pickUp, [-1 -1 -1 90*pi/180], 'LBR7_vrep').*pi/180;
VREPtransfer;
pause(1)
VREPGetJoints;
q*180/pi
%LBRforKin(q,'LBR7_vrep')
%pause()
M_pickUp = [[eye(3)*rotx(90)*roty(90)*roty(90); 0 0 0] [0.48; 0.3; 0.45; 1]]
q = LBRinvKin(M_pickUp, [-1 -1 -1 90*pi/180], 'LBR7_vrep').*pi/180;
VREPtransfer;
%M = LBRforKin(q,'LBR7_med') 
%M = LBRforKin(q,'LBR7_med') 
%VREPtransfer;
pause(1)
% while true
     closeGripper;
     pause();
     q = zeros(7,1);
%     q = input('q= \n')
    VREPtransfer;
% end

VREPdisconnect; % trennt die Verbindung -> nur einmal am Ende aufrufen
%%  0.0000   48.3844    0.0000  113.2619 -180.0000  115.1225  -90.0000

% q0 = zeros(7,1);
% q1 = [30 45 -35 -160 90 20 10].*pi/180;
% 0.5 0.3 0.3