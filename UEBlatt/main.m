%% DONT TOUCH HERE
clear all; close all; clc;

getRobotData;
close all; clear all; clc;

load KUKA_LBR_iiwa_7_R800My.mat;
iiwaDATA.axisOfRot = axisOfRotationMy';
iiwaDATA.lengthV = lengthVectorsMy';
iiwaDATA.originJoint1 = originJoint1My';
clear ans axisOfRotationMy lengthVectorsMy originJoint1My

VREPconnect;
posA = [0.425; 0; 0.05]; % start pos of element
posB = [ -0.425; 0; 0.05]; % todo: choose position


% acceptable error
epsilon = 1e-3; % [m] -> 1 mm
% stepsize eta
eta = 1e-1;
% jacobian numerical derive deltaStep
deltaStep = 1e-3;
% starting at:
q = zeros(7,1); % current joint values

%% FEEL FREE TO TOUCH
VREPtransfer;
fwKinHRM(q,iiwaDATA)

[q,currentPos,e,error] = newtonInKin(epsilon,eta,deltaStep,q,posA,iiwaDATA);

disp('result')
q
currentPos
% e
error

VREPtransfer;

VREPdisconnect; % trennt die Verbindung -> nur einmal am Ende aufrufen
