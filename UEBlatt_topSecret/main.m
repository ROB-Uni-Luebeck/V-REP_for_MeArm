clear all; close all; clc;
robot = 'LBR7_vrep';
%% script what robot does
% connect to vrep
VREPconnect;

% opens gripper
VREPopenGripper;

% starting position
q = zeros(7,1); % current joint values
M_1 = LBRforKin(q,robot);
VREPtransfer;
pause(10);

% pick up pose
M_pickUp = [[eye(3)*roty(180); 0 0 0] [0.50; 0.30; 0.6; 1]];
q = LBRnuminvKin(M_pickUp, q, robot);
VREPtransfer;
pause(5)

for i = 1:6
    M_pickUp = [[eye(3)*roty(180); 0 0 0] [0.50; 0.30; 0.6-0.01*i; 1]];
    q = LBRnuminvKin(M_pickUp, q, robot); 
    VREPtransfer;
end

% close gripper
VREPcloseGripper;
pause(10)

q = zeros(7,1);
VREPtransfer;
pause(2)

M_pickUp = [[eye(3)*rotx(90)*roty(-90); 0 0 0] [-0.51; 0.0; 0.74; 1]];
q = LBRnuminvKin(M_pickUp, q, robot); 
VREPtransfer;
pause(2)

VREPopenGripper;
pause(5);

q = zeros(7,1);
VREPtransfer;

% trennt die Verbindung -> nur einmal am Ende aufrufen
VREPdisconnect;